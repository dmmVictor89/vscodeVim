// Place your key bindings in this file to override the defaultsauto[]
[
    {
        "key": "ctrl+alt+r",
        "command": "-workbench.action.terminal.sendSequence",
        "when": "accessibilityModeEnabled && terminalFocus"
    },
    {
        "key": "ctrl+alt+r",
        "command": "-workbench.action.terminal.runRecentCommand",
        "when": "terminalFocus && terminalHasBeenCreated && !accessibilityModeEnabled || terminalFocus && terminalProcessSupported && !accessibilityModeEnabled"
    },
    {
        "key": "ctrl+d",
        "command": "-editor.action.addSelectionToNextFindMatch",
        "when": "editorFocus"
    },
    {
        "key": "ctrl+d",
        "command": "editor.action.deleteLines",
        "when": "textInputFocus && !editorReadonly"
    },
    {
        "key": "ctrl+shift+k",
        "command": "-editor.action.deleteLines",
        "when": "textInputFocus && !editorReadonly"
    },
    {
        "key": "ctrl+oem_1",
        "command": "editor.action.smartSelect.expand",
        "when": "editorTextFocus"
    },
    {
        "key": "shift+alt+right",
        "command": "-editor.action.smartSelect.expand",
        "when": "editorTextFocus"
    },
    {
        "key": "f2",
        "command": "-workbench.action.terminal.renameActiveTab",
        "when": "terminalHasBeenCreated && terminalTabsFocus && terminalTabsSingularSelection || terminalProcessSupported && terminalTabsFocus && terminalTabsSingularSelection"
    },
    {
        "key": "f2",
        "command": "-renameFile",
        "when": "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
    },
    {
        "key": "f2",
        "command": "-remote.tunnel.label",
        "when": "tunnelViewFocus && tunnelType == 'Forwarded' && tunnelViewMultiSelection == 'undefined'"
    },
    {
        "key": "f2",
        "command": "-debug.setVariable",
        "when": "variablesFocused"
    },
    {
        "key": "f2",
        "command": "-debug.renameWatchExpression",
        "when": "watchExpressionsFocused"
    },
    {
        "key": "f2",
        "command": "-editor.action.rename",
        "when": "editorHasRenameProvider && editorTextFocus && !editorReadonly"
    },
    {
        "key": "f1",
        "command": "editor.action.previousMatchFindAction",
        "when": "editorFocus"
    },
    {
        "key": "shift+f3",
        "command": "-editor.action.previousMatchFindAction",
        "when": "editorFocus"
    },
    {
        "key": "ctrl+left",
        "command": "workbench.action.navigateBack",
        "when": "canNavigateBack"
    },
    {
        "key": "alt+left",
        "command": "-workbench.action.navigateBack",
        "when": "canNavigateBack"
    },
    {
        "key": "ctrl+right",
        "command": "workbench.action.navigateForward",
        "when": "canNavigateForward"
    },
    {
        "key": "alt+right",
        "command": "-workbench.action.navigateForward",
        "when": "canNavigateForward"
    },
    {
        "key": "ctrl+alt+1",
        "command": "workbench.action.navigatePreviousInEditLocations"
    },
    {
        "key": "f3",
        "command": "editor.action.revealDefinition",
        "when": "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor"
    },
    {
        "key": "f12",
        "command": "-editor.action.revealDefinition",
        "when": "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor"
    },
    {
        "key": "alt+a",
        "command": "workbench.action.quickOpen"
    },
    {
        "key": "ctrl+e",
        "command": "-workbench.action.quickOpen"
    },
    {
        "key": "ctrl+f3",
        "command": "editor.action.goToImplementation",
        "when": "editorHasImplementationProvider && editorTextFocus && !isInEmbeddedEditor"
    },
    {
        "key": "ctrl+f12",
        "command": "-editor.action.goToImplementation",
        "when": "editorHasImplementationProvider && editorTextFocus && !isInEmbeddedEditor"
    },
    {
        "key": "ctrl+q",
        "command": "workbench.action.navigateToLastEditLocation"
    },
    {
        "key": "ctrl+k ctrl+q",
        "command": "-workbench.action.navigateToLastEditLocation"
    },
    {
        "key": "shift+f5",
        "command": "editor.action.goToReferences",
        "when": "editorHasReferenceProvider && editorTextFocus && !inReferenceSearchEditor && !isInEmbeddedEditor"
    },
    {
        "key": "shift+f12",
        "command": "-editor.action.goToReferences",
        "when": "editorHasReferenceProvider && editorTextFocus && !inReferenceSearchEditor && !isInEmbeddedEditor"
    },
    {
        "key": "alt+s",
        "command": "editor.action.clipboardPasteAction"
    },
    {
        "key": "alt+f",
        "command": "workbench.action.findInFiles"
    },
    {
        "key": "ctrl+shift+f",
        "command": "-workbench.action.findInFiles"
    },
    {
        "key": "ctrl+alt+oem_2",
        "command": "editor.action.blockComment",
        "when": "editorTextFocus && !editorReadonly"
    },
    {
        "key": "shift+alt+a",
        "command": "-editor.action.blockComment",
        "when": "editorTextFocus && !editorReadonly"
    },
    {
        "key": "shift+alt+c",
        "command": "-copyFilePath",
        "when": "!editorFocus"
    },
    {
        "key": "shift+alt+c",
        "command": "-search.action.copyPath",
        "when": "fileMatchOrFolderMatchWithResourceFocus"
    },
    {
        "key": "shift+alt+c",
        "command": "-copyFilePath",
        "when": "editorFocus"
    },
    {
        "key": "shift+alt+c",
        "command": "editor.action.toggleColumnSelection"
    },
    {
        "key": "ctrl+shift+w",
        "command": "-workbench.action.closeWindow"
    },
    {
        "key": "ctrl+shift+w",
        "command": "workbench.action.closeAllEditors"
    },
    {
        "key": "ctrl+k ctrl+w",
        "command": "-workbench.action.closeAllEditors"
    },
    {
        "key": "ctrl+k ctrl+m",
        "command": "-workbench.action.toggleMaximizeEditorGroup",
        "when": "editorPartMaximizedEditorGroup || editorPartMultipleEditorGroups"
    },
    {
        "key": "alt+e",
        "command": "workbench.view.explorer",
        "when": "viewContainer.workbench.view.explorer.enabled"
    },
    {
        "key": "ctrl+shift+e",
        "command": "-workbench.view.explorer",
        "when": "viewContainer.workbench.view.explorer.enabled"
    },
    {
        "key": "alt+d",
        "command": "workbench.view.debug",
        "when": "viewContainer.workbench.view.debug.enabled"
    },
    {
        "key": "ctrl+shift+d",
        "command": "-workbench.view.debug",
        "when": "viewContainer.workbench.view.debug.enabled"
    },
    {
        "key": "alt+3",
        "command": "-workbench.action.openEditorAtIndex3"
    },
    {
        "key": "alt+3",
        "command": "workbench.action.togglePanel"
    },
    {
        "key": "ctrl+j",
        "command": "-workbench.action.togglePanel"
    },
    {
        "key": "alt+b",
        "command": "workbench.action.editorLayoutTwoColumns"
    },
    {
        "key": "f5",
        "command": "editor.gotoNextSymbolFromResult",
        "when": "hasSymbols"
    },
    {
        "key": "f12",
        "command": "-editor.gotoNextSymbolFromResult",
        "when": "hasSymbols"
    },
    {
        "key": "f5",
        "command": "goToNextReference",
        "when": "inReferenceSearchEditor || referenceSearchVisible"
    },
    {
        "key": "f12",
        "command": "-goToNextReference",
        "when": "inReferenceSearchEditor || referenceSearchVisible"
    },
    {
        "key": "f6",
        "command": "references-view.prev",
        "when": "reference-list.hasResult && references-view.canNavigate"
    },
    {
        "key": "shift+f4",
        "command": "-references-view.prev",
        "when": "reference-list.hasResult && references-view.canNavigate"
    },
    {
        "key": "alt+g",
        "command": "workbench.action.toggleMaximizeEditorGroup"
    },
    {
        "key": "f1",
        "command": "renameFile"
    },
    {
        "key": "f2",
        "command": "editor.action.nextMatchFindAction",
        "when": "editorFocus"
    },
    {
        "key": "ctrl+m",
        "command": "editor.action.replaceOne",
        "when": "editorFocus && findWidgetVisible"
    },
    {
        "key": "alt+v",
        "command": "workbench.action.toggleSidebarVisibility"
    },
    {
        "key": "ctrl+alt+d",
        "command": "bookmarks.jumpToNext",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+alt+l",
        "command": "-bookmarks.jumpToNext",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+alt+s",
        "command": "bookmarks.jumpToPrevious",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+alt+j",
        "command": "-bookmarks.jumpToPrevious",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+alt+r",
        "command": "bookmarks.toggle",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+alt+k",
        "command": "-bookmarks.toggle",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+alt+t",
        "command": "bookmarks.clear"
    },
    {
        "key": "ctrl+alt+b",
        "command": "-workbench.action.toggleAuxiliaryBar"
    },
    {
        "key": "ctrl+shift+alt+t",
        "command": "bookmarks.clearFromAllFiles"
    },
    {
        "key": "ctrl+shift+alt+b",
        "command": "bookmarks.listFromAllFiles"
    },
    {
        "key": "ctrl+alt+b",
        "command": "workbench.view.extension.bookmarks"
    },
    {
        "key": "ctrl+alt+p",
        "command": "workbench.action.pinEditor",
        "when": "!activeEditorIsPinned"
    },
    {
        "key": "ctrl+k shift+enter",
        "command": "-workbench.action.pinEditor",
        "when": "!activeEditorIsPinned"
    },
    {
        "key": "ctrl+alt+p",
        "command": "workbench.action.unpinEditor",
        "when": "activeEditorIsPinned"
    },
    {
        "key": "ctrl+k shift+enter",
        "command": "-workbench.action.unpinEditor",
        "when": "activeEditorIsPinned"
    },
    {
        "key": "ctrl+shift+alt+s",
        "command": "saveAll"
    },
    {
        "key": "ctrl+k s",
        "command": "-saveAll"
    },
    {
        "key": "ctrl+alt+x",
        "command": "editor.action.transformToCamelcase"
    },
    {
        "key": "alt+2",
        "command": "java.debug.runJavaFile"
    },
    {
        "key": "ctrl+t ctrl+k",
        "command": "workbench.action.editor.changeEncoding"
    },
    {
        "key": "ctrl+alt+c",
        "command": "workbench.action.terminal.toggleFindCaseSensitive",
        "when": "terminalFindFocused && terminalHasBeenCreated || terminalFindFocused && terminalProcessSupported || terminalFocusInAny && terminalHasBeenCreated || terminalFocusInAny && terminalProcessSupported"
    },
    {
        "key": "alt+c",
        "command": "-workbench.action.terminal.toggleFindCaseSensitive",
        "when": "terminalFindFocused && terminalHasBeenCreated || terminalFindFocused && terminalProcessSupported || terminalFocusInAny && terminalHasBeenCreated || terminalFocusInAny && terminalProcessSupported"
    },
    {
        "key": "ctrl+alt+c",
        "command": "toggleSearchEditorCaseSensitive",
        "when": "inSearchEditor && searchInputBoxFocus"
    },
    {
        "key": "alt+c",
        "command": "-toggleSearchEditorCaseSensitive",
        "when": "inSearchEditor && searchInputBoxFocus"
    },
    {
        "key": "ctrl+alt+c",
        "command": "toggleFindCaseSensitive",
        "when": "editorFocus"
    },
    {
        "key": "alt+c",
        "command": "-toggleFindCaseSensitive",
        "when": "editorFocus"
    },
    {
        "key": "ctrl+alt+c",
        "command": "toggleSearchCaseSensitive",
        "when": "searchViewletFocus"
    },
    {
        "key": "alt+c",
        "command": "-toggleSearchCaseSensitive",
        "when": "searchViewletFocus"
    },
    {
        "key": "alt+c",
        "command": "references-view.showCallHierarchy",
        "when": "editorHasCallHierarchyProvider"
    },
    {
        "key": "ctrl+f1",
        "command": "workbench.action.showCommands"
    },
    {
        "key": "f1",
        "command": "-workbench.action.showCommands"
    },
    {
        "key": "f1",
        "command": "remote.tunnel.label",
        "when": "tunnelViewFocus && tunnelType == 'Forwarded' && tunnelViewMultiSelection == 'undefined'"
    },
    {
        "key": "f3",
        "command": "-editor.action.nextMatchFindAction",
        "when": "editorFocus"
    },
    {
        "key": "f2",
        "command": "list.find",
        "when": "listFocus && listSupportsFind"
    },
    {
        "key": "f3",
        "command": "-list.find",
        "when": "listFocus && listSupportsFind"
    },
    {
        "key": "f2",
        "command": "workbench.action.terminal.findNext",
        "when": "terminalFindFocused && terminalHasBeenCreated || terminalFindFocused && terminalProcessSupported || terminalFocusInAny && terminalHasBeenCreated || terminalFocusInAny && terminalProcessSupported"
    },
    {
        "key": "f3",
        "command": "-workbench.action.terminal.findNext",
        "when": "terminalFindFocused && terminalHasBeenCreated || terminalFindFocused && terminalProcessSupported || terminalFocusInAny && terminalHasBeenCreated || terminalFocusInAny && terminalProcessSupported"
    },
    {
        "key": "f5",
        "command": "references-view.next",
        "when": "reference-list.hasResult && references-view.canNavigate"
    },
    {
        "key": "f4",
        "command": "-references-view.next",
        "when": "reference-list.hasResult && references-view.canNavigate"
    },
    {
        "key": "f5",
        "command": "search.action.focusNextSearchResult",
        "when": "hasSearchResult || inSearchEditor"
    },
    {
        "key": "f4",
        "command": "-search.action.focusNextSearchResult",
        "when": "hasSearchResult || inSearchEditor"
    },
    {
        "key": "f4",
        "command": "-goToNextReference",
        "when": "inReferenceSearchEditor || referenceSearchVisible"
    },
    {
        "key": "shift+f5",
        "command": "goToPreviousReference",
        "when": "inReferenceSearchEditor || referenceSearchVisible"
    },
    {
        "key": "shift+f4",
        "command": "-goToPreviousReference",
        "when": "inReferenceSearchEditor || referenceSearchVisible"
    },
    {
        "key": "f4",
        "command": "workbench.action.navigateBack",
        "when": "canNavigateBack"
    },
    {
        "key": "ctrl+j",
        "command": "editor.action.nextMatchFindAction",
        "when": "editorFocus"
    },
    {
        "key": "ctrl+alt+u",
        "command": "editor.action.transformToUppercase"
    },
    {
        "key": "ctrl+alt+l",
        "command": "editor.action.transformToLowercase"
    },
    {
        "key": "alt+x",
        "command": "outline.focus"
    },
    {
        "key": "ctrl+b",
        "command": "-workbench.action.toggleSidebarVisibility"
    },
    {
        "key": "ctrl+shift+alt+q",
        "command": "copyFilePath"
    },
    {
        "key": "alt+2",
        "command": "-workbench.action.openEditorAtIndex2"
    },
    {
        "key": "ctrl+shift+alt+d",
        "command": "workbench.action.terminal.clear"
    },
    {
        "key": "ctrl+shift+f",
        "command": "editor.action.formatSelection",
        "when": "editorHasDocumentSelectionFormattingProvider && editorTextFocus && !editorReadonly"
    },
    {
        "key": "ctrl+k ctrl+f",
        "command": "-editor.action.formatSelection",
        "when": "editorHasDocumentSelectionFormattingProvider && editorTextFocus && !editorReadonly"
    },
    {
        "key": "ctrl+alt+v",
        "command": "-workbench.action.editorDictation.start",
        "when": "hasSpeechProvider && !editorReadonly && !speechToTextInProgress"
    },
    {
        "key": "ctrl+k ctrl+m",
        "command": "workbench.action.toggleZenMode",
        "when": "!isAuxiliaryWindowFocusedContext"
    },
    {
        "key": "ctrl+k z",
        "command": "-workbench.action.toggleZenMode",
        "when": "!isAuxiliaryWindowFocusedContext"
    },
    {
        "key": "ctrl+k z",
        "command": "workbench.action.toggleZenMode",
        "when": "!isAuxiliaryWindowFocusedContext"
    },
    {
        "key": "ctrl+m",
        "command": "-editor.action.toggleTabFocusMode"
    },
    {
        "key": "ctrl+m",
        "command": "-extension.vim_ctrl+m",
        "when": "editorTextFocus && vim.active && vim.use<C-m> && !inDebugRepl || vim.active && vim.use<C-m> && !inDebugRepl && vim.mode == 'CommandlineInProgress' || vim.active && vim.use<C-m> && !inDebugRepl && vim.mode == 'SearchInProgressMode'"
    },
    {
        "key": "ctrl+pageup",
        "command": "-extension.vim_ctrl+pageup",
        "when": "editorTextFocus && vim.active && vim.use<C-pageup> && !inDebugRepl"
    },
    {
        "key": "ctrl+pagedown",
        "command": "-extension.vim_ctrl+pagedown",
        "when": "editorTextFocus && vim.active && vim.use<C-pagedown> && !inDebugRepl"
    },
    {
        "key": "ctrl+shift+alt+l",
        "command": "turboConsoleLog.displayLogMessage"
    },
    {
        "key": "ctrl+alt+l",
        "command": "-turboConsoleLog.displayLogMessage"
    },
    {
        "key": "ctrl+r",
        "command": "-workbench.action.reloadWindow",
        "when": "isDevelopment"
    },
    {
        "key": "ctrl+r",
        "command": "-workbench.action.openRecent"
    },
    {
        "key": "ctrl+r",
        "command": "-python.refreshTensorBoard",
        "when": "python.hasActiveTensorBoardSession"
    },
    {
        "key": "ctrl+r",
        "command": "-workbench.action.terminal.runRecentCommand",
        "when": "accessibilityModeEnabled && terminalFocus && terminalHasBeenCreated || accessibilityModeEnabled && terminalFocus && terminalProcessSupported || accessibilityModeEnabled && accessibleViewIsShown && terminalHasBeenCreated && accessibleViewCurrentProviderId == 'terminal' || accessibilityModeEnabled && accessibleViewIsShown && terminalProcessSupported && accessibleViewCurrentProviderId == 'terminal'"
    },
    {
        "key": "ctrl+r",
        "command": "-inlineChat.regenerate",
        "when": "inlineChatHasProvider && inlineChatVisible"
    },
    {
        "key": "ctrl+r",
        "command": "-workbench.action.quickOpenNavigateNextInRecentFilesPicker",
        "when": "inQuickOpen && inRecentFilesPicker"
    },
    {
        "key": "ctrl+alt+h",
        "command": "todohighlight.toggleHighlight"
    },
    {
        "key": "ctrl+alt+g",
        "command": "-workbench.action.terminal.sendSequence",
        "when": "terminalFocus"
    },
  // *************************************************** vim start *************************************************** //
    {
        "key": "ctrl+shift+alt+i",  // 원하는 단축키 조합
        "command": "vscode-neovim.restart",  // Neovim 확장을 활성화하는 명령
        // "when": "vscode-neovim.stop"
    },
    {
        "key": "ctrl+alt+v",  // 같은 단축키로 비활성화도 수행
        "command": "vscode-neovim.stop",
        "when": "!vscode-neovim.stop"
    },
    {
        "key": "ctrl+c",
        "command": "editor.action.clipboardCopyAction",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+v",
        "command": "editor.action.clipboardPasteAction",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+z",
        "command": "undo",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+d",
        "command": "editor.action.deleteLines",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+s",
        "command": "workbench.action.files.save",
    },
    {
        "key": "ctrl+x",
        "command": "editor.action.clipboardCutAction",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+a",
        "command": "editor.action.selectAll",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+f",
        "command": "actions.find",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+h",
        "command": "editor.action.startFindReplaceAction",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+j",
        "command": "editor.action.nextMatchFindAction",
        "when": "editorTextFocus"
    },
    // {
    //     "key": "ctrl+w",
    //     "command": "workbench.action.closeActiveEditor",
    //     "when": "editorTextFocus"
    // },
    {
        "key": "ctrl+g",
        "command": "workbench.action.gotoLine",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+y",
        "command": "redo",
        "when": "editorTextFocus"
    },
    {
        "key": "delete",
        "command": "vscode-neovim.send",
        "args": "<Esc>\"_x",
        "when": "editorTextFocus && vim.mode == 'Normal'"
    },
    {
        "key": "delete",
        "command": "vscode-neovim.send",
        "args": "\"_x",
        "when": "editorTextFocus && vim.mode == 'Visual'"
    },
    {
        "key": "shift-k",
        "command": "editor.action.showHover",
        "when": "vim.mode = 'Normal' && editorTextFocus"
    },
    {
        "key": "ctrl+shift+alt+e",
        "command": "workbench.view.extensions",
        "when": "viewContainer.workbench.view.extensions.enabled"
    },
    {
        "key": "ctrl+shift+x",
        "command": "-workbench.view.extensions",
        "when": "viewContainer.workbench.view.extensions.enabled"
    }
// *************************************************** vim end *************************************************** //
]
