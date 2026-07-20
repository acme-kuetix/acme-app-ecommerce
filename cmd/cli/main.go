package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/kuetix/engine"
	"github.com/kuetix/engine/engine/domain"
	engineModule "github.com/kuetix/engine/modules"
	stdAuthModules "github.com/kuetix/std-auth/modules"
	stdCoreModules "github.com/kuetix/std-core/modules"
	stdHttpModules "github.com/kuetix/std-http/modules"

	ecommerce "github.com/acme-kuetix/acme-app-ecommerce"
	ecommerceModules "github.com/acme-kuetix/acme-app-ecommerce/modules"
)

var Version = "dev"
var BuildTime = "unknown"

func main() {
	if len(os.Args) < 2 {
		fmt.Printf("Usage: %s <workflow_name> [-v|-verbose] [-port]\n", os.Args[0])
		fmt.Printf("Example: %s solutions/ecommerce/startup\n", os.Args[0])
		os.Exit(1)
	}

	workflow := os.Args[1]
	os.Args = os.Args[1:]
	verbose := flag.Bool("verbose", false, "Verbose mode")
	vFlag := flag.Bool("v", false, "Verbose mode")
	port := flag.String("port", "9997", "HTTP server port")
	flag.Parse()

	workflowPathList := ecommerceModules.WorkflowPathList

	engineModule.Enable()
	stdCoreModules.Enable()
	stdAuthModules.Enable()
	stdHttpModules.Enable()
	if err := ecommerceModules.Enable(); err != nil {
		fmt.Printf("Error: %s\n", err)
		os.Exit(1)
	}

	response := engine.RunWorkflow("production", &domain.Options{
		Version:         Version,
		BuildTime:       BuildTime,
		EngineName:      "acme-app-ecommerce",
		ConfigName:      "engine",
		Verbose:         *verbose || *vFlag,
		Quiet:           false,
		Amount:          1,
		Retry:           1,
		RetryDelay:      0,
		RestartPolicy:   "stop",
		Workflow:        workflow,
		LogPath:         "stdout",
		Config: &domain.Config{
			Application: domain.ApplicationConfig{
				WorkflowsPath:     "workflows",
				WorkflowsPathList: workflowPathList,
			},
		},
		Args:            append([]string{"port=" + *port}, flag.Args()...),
		Context:         nil,
		Settings:        nil,
		EmbedFS:         &ecommerce.WorkflowsFS,
		EmbedFSRootPath: ecommerce.WorkflowsFSPath,
	})

	for _, res := range response {
		if res.Error != nil {
			fmt.Printf("Error: %s\n", res.Error)
			os.Exit(1)
		}
		if res.Response != nil {
			fmt.Printf("Result: %v\n", res.Response)
		}
	}
}
