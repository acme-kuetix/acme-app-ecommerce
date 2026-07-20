package ecommerce

import "embed"

//go:embed all:workflows
var WorkflowsFS embed.FS

const WorkflowsFSPath = "workflows"
