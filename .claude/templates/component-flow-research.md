# Component Flow Research Template

## Research Report: [Component/Feature Name]

**Research Date**: [YYYY-MM-DD]  
**Researcher**: [Agent/Human Name]  
**Scope**: [Brief description of what was analyzed]

## Component Usage Flow

### [Primary Flow Name] (Status: ✅ Working / ❌ Broken / ⚠️ Partial)

1. **Entry Point**: `file_path:line_number` - [Description of how flow starts]
2. **Processing**: `file_path:line_number` - [Key processing or logic step]
3. **Data Layer**: `file_path:line_number` - [Database/API interaction]
4. **Output**: `file_path:line_number` - [Final result or rendering]

### [Secondary Flow Name] (Status: ✅ Working / ❌ Broken / ⚠️ Partial)

1. **Trigger**: `file_path:line_number` - [What initiates this flow]
2. **Validation**: `file_path:line_number` - [Input validation or checks]
3. **Processing**: `file_path:line_number` - [Core business logic]
4. **Response**: `file_path:line_number` - [How results are handled]

## Architecture Overview

### Framework & Libraries
- **Framework**: [Next.js, React, Vue, etc. with version]
- **State Management**: [Redux, Zustand, Context, etc.]
- **Data Fetching**: [TanStack Query, SWR, native fetch, etc.]
- **Styling**: [Tailwind, styled-components, CSS modules, etc.]
- **Type System**: [TypeScript, PropTypes, etc.]

### Key Integration Points
- **Authentication**: `file_path:line_number` - [Auth system integration]
- **API Layer**: `file_path:line_number` - [Backend communication]
- **State Updates**: `file_path:line_number` - [How state changes propagate]
- **Error Handling**: `file_path:line_number` - [Error boundary or handling]

## Code References

### Core Components
- `src/components/ComponentName.tsx:line` - [Component purpose and key props]
- `src/hooks/useHookName.ts:line` - [Custom hook functionality]
- `src/services/serviceName.ts:line` - [Service layer function]

### Configuration & Setup
- `src/app/layout.tsx:line` - [Layout or provider setup]
- `src/lib/config.ts:line` - [Configuration values]
- `package.json:line` - [Relevant dependencies]

### Types & Interfaces
- `src/types/typeName.ts:line` - [Type definition]
- `src/interfaces/interfaceName.ts:line` - [Interface definition]

## Testing Coverage
- **Unit Tests**: `src/__tests__/ComponentName.test.tsx` - [Test coverage status]
- **Integration Tests**: `src/__tests__/integration/` - [Integration test status]
- **E2E Tests**: `cypress/e2e/` - [End-to-end test coverage]

## Dependencies & External Services
- **External APIs**: [List of external services and endpoints]
- **Third-party Libraries**: [Key dependencies and their usage]
- **Environment Variables**: [Required env vars and their purpose]

## Patterns & Conventions
- **File Organization**: [How files are structured and named]
- **Component Patterns**: [HOCs, render props, hooks patterns used]
- **State Patterns**: [How state is managed and updated]
- **Error Patterns**: [How errors are handled and displayed]

## Gotchas & Important Notes
- ⚠️ [Any important warnings or edge cases]
- 💡 [Performance considerations or optimizations]
- 🔧 [Configuration gotchas or setup requirements]
- 📝 [Development workflow notes]

## Next Steps
- [ ] [Recommended next actions based on analysis]
- [ ] [Areas that need improvement or refactoring]
- [ ] [Missing tests or documentation]
- [ ] [Performance optimizations to consider]