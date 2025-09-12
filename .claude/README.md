# Context Engineering System

A comprehensive context engineering system for Claude Code that implements spec-first development workflows inspired by advanced AI development practices.

## Overview

This system transforms traditional "vibe coding" into structured, spec-first development with proper context management. It includes research agents, planning tools, context compaction, and quality gates to maximize AI productivity while maintaining code quality.

## Core Components

### 🔍 Research Infrastructure
- **Research Agent** (`.claude/agents/research-agent.md`): Specialized agent for codebase analysis
- **Research Templates** (`.claude/templates/`): Structured templates for component flow analysis
- **Research Reports** (`.claude/research-reports/`): Generated research findings with file:line references

### 📋 Plan-First Development
- **Plan Generation Agent** (`.claude/agents/plan-generation-agent.md`): Creates detailed implementation plans
- **Implementation Plans** (`.claude/implementation-plans/`): Step-by-step development roadmaps
- **Spec-First Guards** (`.claude/hooks/spec-first-guard.sh`): Reminds to research and plan before coding

### 🎯 Context Management
- **Context Monitor** (`.claude/hooks/context-monitor.sh`): Tracks context utilization and warns at >40%
- **Context Compaction** (`.claude/hooks/context-compaction.sh`): Automatic summaries when approaching limits
- **Progress Persistence** (`.claude/hooks/progress-saver.sh`): Saves development state between sessions

### 🤖 Sub-Agent Framework
- **Search Specialist** (`.claude/sub-agents/search-specialist.md`): Focused code searches with summaries
- **Testing Specialist** (`.claude/sub-agents/testing-specialist.md`): Test strategy and coverage analysis
- **Architecture Analyst** (`.claude/sub-agents/architecture-analyst.md`): System architecture analysis

### 🛡️ Quality Gates
- **Quality Gate Hook** (`.claude/hooks/quality-gate.sh`): Pre-commit linting, type checking, and testing
- **Todo Persistence** (`.claude/hooks/todo-persistence.sh`): Tracks task progress across sessions
- **Session Bootstrap** (`.claude/hooks/session-bootstrap.sh`): Loads previous context on startup

## Workflow

### 1. Research Phase
```bash
# Use research agent to analyze relevant code areas
# Generate research report with component flows and file references
# Output: .claude/research-reports/[feature-name].md
```

### 2. Planning Phase
```bash
# Create detailed implementation plan based on research
# Include specific file paths, line numbers, and code snippets
# Output: .claude/implementation-plans/[feature-name].md
```

### 3. Implementation Phase
- Context monitoring keeps utilization <40%
- Spec-first guards remind about research and planning
- Quality gates ensure code standards are met
- Progress is automatically saved for session continuity

## Active Hooks

### PreToolUse
- **Bash Command Logging**: Records all bash commands for debugging
- **pnpm Enforcement**: Prevents npm usage, enforces pnpm for consistency
- **Quality Gates**: Pre-commit checks for linting, type checking, and tests
- **Context Monitor**: Tracks context usage and provides warnings
- **Spec-First Guard**: Advisory reminders for research-first development

### PostToolUse
- **Todo Persistence**: Saves todo state for session continuity
- **Progress Saver**: Creates progress snapshots with context summaries

### Session Lifecycle
- **SessionStart**: Bootstrap hook loads previous todos and progress
- **SessionEnd**: Saves conversation transcripts and final state

## Commands Available

- `/generate-research` - Create comprehensive research report
- `/create-implementation-plan` - Generate detailed implementation plan
- `/delegate-to-sub-agent` - Use specialized sub-agents for focused tasks

## Context Engineering Principles

### 1. Hierarchy of Mistakes
- Bad research → thousands of bad lines of code
- Bad plan → hundreds of bad lines of code  
- Bad line of code → just one bad line of code

### 2. Context Efficiency
- Keep context utilization under 40%
- Use sub-agents for detailed searches
- Compress findings into structured summaries
- Preserve only essential context between sessions

### 3. Spec-First Development
- Research before planning
- Plan before implementing
- Review specs, not just code
- Save progress for context continuity

## Benefits

- **10x Faster Development**: Structured approach eliminates wasted iterations
- **Higher Code Quality**: Quality gates prevent shipping broken code
- **Context Efficiency**: Smart management keeps AI agents focused
- **Session Continuity**: Progress persists across development sessions
- **Scalable Reviews**: Review plans and specs instead of massive diffs

## Getting Started

The system is automatically active through the configured hooks. Start any development task and the context engineering system will guide you through the research → plan → implement workflow.

For new features:
1. Let the system guide you to research first
2. Use the research to create an implementation plan
3. Execute the plan with automatic context management
4. Quality gates ensure code standards before commits

This system transforms AI-assisted development from ad-hoc coding into a structured, production-ready workflow.