Create Implementation Plan

Generate a detailed, spec-first implementation plan for a feature or bug fix. This command creates a structured plan with specific file references, line numbers, and step-by-step instructions that keep context utilization under 40%.

Usage:
- Provide feature description or bug report
- Agent creates detailed implementation plan
- Plan includes phases, specific steps, testing strategy
- Output saved to `.claude/implementation-plans/[feature-name].md`

The implementation plan will include:
- Step-by-step implementation phases
- Specific file paths and line numbers to modify
- Code snippets showing before/after changes
- Comprehensive testing strategy
- Risk assessment and quality gates
- Context compaction summary for future reference