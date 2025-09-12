# Implementation Plan Template

## Plan: [Feature/Bug Fix Name]

**Created**: [YYYY-MM-DD]  
**Planner**: [Agent/Human Name]  
**Estimated Complexity**: [Low/Medium/High]  
**Context Window Target**: <40% utilization

## Summary
[1-3 sentence description of what will be implemented]

## Prerequisites
- [ ] Research completed: `research-reports/[feature-name].md`
- [ ] Dependencies identified and available
- [ ] Testing strategy defined
- [ ] Acceptance criteria clarified

## Implementation Steps

### Phase 1: [Phase Name]
**Files to modify**: `src/path/file1.tsx`, `src/path/file2.ts`

#### Step 1.1: [Specific action]
- **File**: `src/path/file.tsx`
- **Lines**: `45-67` (modify existing function)
- **Action**: [Detailed description of what changes]
- **Code snippet**:
  ```typescript
  // Before:
  const oldFunction = () => { ... }
  
  // After:
  const newFunction = (param: Type) => { ... }
  ```
- **Test**: [How this step will be verified]

#### Step 1.2: [Specific action]
- **File**: `src/path/new-file.ts` (create new)
- **Action**: [Description of new file purpose]
- **Dependencies**: [Required imports or setup]
- **Test**: [Verification method]

### Phase 2: [Phase Name]
**Files to modify**: `src/path/file3.tsx`, `tests/file.test.ts`

#### Step 2.1: [Specific action]
- **File**: `src/path/file.tsx:line_number`
- **Action**: [Detailed change description]
- **Context**: [Why this change is needed]
- **Test**: [Verification approach]

## Testing Strategy

### Unit Tests
- [ ] `src/__tests__/component.test.tsx` - Test component rendering
- [ ] `src/__tests__/service.test.ts` - Test business logic
- [ ] `src/__tests__/hooks.test.ts` - Test custom hooks

### Integration Tests  
- [ ] `src/__tests__/integration/flow.test.tsx` - Test complete user flow
- [ ] `src/__tests__/integration/api.test.ts` - Test API integration

### Manual Testing
- [ ] Test happy path: [Description]
- [ ] Test error cases: [Description]
- [ ] Test edge cases: [Description]

## Risk Assessment

### High Risk Areas
- [Area 1]: [Description and mitigation]
- [Area 2]: [Description and mitigation]

### Dependencies
- [External service/API]: [Availability and backup plan]
- [Library/framework]: [Version compatibility]

## Quality Gates

### Before Committing
- [ ] All unit tests pass
- [ ] Integration tests pass
- [ ] Linting passes (`npm run lint`)
- [ ] Type checking passes (`npm run typecheck`)
- [ ] Manual testing completed

### Before PR
- [ ] Code review checklist completed
- [ ] Documentation updated
- [ ] Performance impact assessed
- [ ] Security considerations reviewed

## Context Compaction

### Key Insights to Preserve
- [Critical architectural decision]
- [Important gotcha or edge case]
- [Performance consideration]

### Files Modified Summary
- `file1.tsx`: [Brief description of changes]
- `file2.ts`: [Brief description of changes]
- `new-file.ts`: [Purpose of new file]

## Post-Implementation

### Verification Steps
- [ ] Feature works as specified
- [ ] No regressions introduced
- [ ] Performance benchmarks met
- [ ] Error handling works correctly

### Documentation Updates
- [ ] README updated if needed
- [ ] API docs updated
- [ ] Architecture docs updated
- [ ] `.claude.md` updated with new patterns

### Cleanup Tasks
- [ ] Remove debug code
- [ ] Clean up console.log statements
- [ ] Remove unused imports
- [ ] Update comments and documentation