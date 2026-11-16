-- Zhixu — Everything in its place. Canonical palette: ../../PALETTE.md.
vim.cmd('highlight clear')
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.g.colors_name = 'zhixu'

local c = {
  bg = '#101112', panel = '#0D0E0F', raised = '#1A1C1E', line = '#181A1C',
  fg = '#E3DCD3', identifier = '#CEC8C0', ui = '#CFC3B7', dim = '#9B8D80',
  comment = '#8295A3', type = '#A8CAA0', keyword = '#DDB08C', string = '#B8ACD4',
  number = '#C3A6B6', macro = '#C7A68B', modifier = '#CAA28C', heading = '#D7AD8E',
  blue = '#91ADC7', cyan = '#91BEBB', error = '#D49A91', success = '#A8B59A',
  border = '#34383D', subtle = '#788691', selection = '#43382F', search = '#624732',
  occurrence = '#2F2924', inactive_selection = '#2F2823', bracket = '#433931',
  added = '#171C1A', removed = '#1F1819', changed = '#263341', diff_text = '#34485A',
  error_bg = '#44272A', warning_bg = '#3D3024', info_bg = '#202C36', hint_bg = '#223431',
}

local function hi(group, style)
  vim.api.nvim_set_hl(0, group, style)
end

local groups = {
  Normal = { fg = c.fg, bg = c.bg }, NormalNC = { fg = c.fg, bg = c.bg },
  NormalFloat = { fg = c.ui, bg = c.raised }, FloatBorder = { fg = c.border, bg = c.raised },
  FloatTitle = { fg = c.keyword, bg = c.raised }, FloatFooter = { fg = c.dim, bg = c.raised },
  Cursor = { fg = c.bg, bg = c.keyword }, lCursor = { fg = c.bg, bg = c.keyword },
  CursorIM = { fg = c.bg, bg = c.keyword }, TermCursor = { fg = c.bg, bg = c.keyword },
  CursorLine = { bg = c.line }, CursorColumn = { bg = c.line },
  ColorColumn = { bg = '#1E1C1A' }, LineNr = { fg = c.subtle, bg = c.bg },
  LineNrAbove = { fg = c.subtle }, LineNrBelow = { fg = c.subtle },
  CursorLineNr = { fg = c.keyword, bg = c.line }, SignColumn = { bg = c.bg },
  CursorLineSign = { bg = c.line }, CursorLineFold = { fg = c.subtle, bg = c.line },
  FoldColumn = { fg = c.subtle, bg = c.bg }, Folded = { fg = c.subtle, bg = c.line },
  NonText = { fg = c.subtle }, EndOfBuffer = { fg = c.bg }, Whitespace = { fg = c.subtle },
  SpecialKey = { fg = c.subtle }, Conceal = { fg = c.subtle },
  WinSeparator = { fg = c.border }, VertSplit = { fg = c.border },
  StatusLine = { fg = c.ui, bg = c.raised }, StatusLineNC = { fg = c.dim, bg = c.panel },
  WinBar = { fg = c.ui, bg = c.raised }, WinBarNC = { fg = c.dim, bg = c.panel },
  TabLine = { fg = c.dim, bg = c.panel }, TabLineFill = { bg = c.panel },
  TabLineSel = { fg = c.keyword, bg = c.raised },
  Pmenu = { fg = c.ui, bg = c.raised }, PmenuSel = { bg = c.selection },
  PmenuSbar = { bg = c.panel }, PmenuThumb = { bg = '#4A3F37' },
  PmenuKind = { fg = c.type, bg = c.raised }, PmenuKindSel = { fg = c.type, bg = c.selection },
  PmenuExtra = { fg = c.dim, bg = c.raised }, PmenuExtraSel = { fg = c.dim, bg = c.selection },
  PmenuMatch = { fg = c.keyword }, PmenuMatchSel = { fg = c.keyword, bg = c.selection },
  Visual = { bg = c.selection }, VisualNOS = { bg = c.inactive_selection },
  Search = { bg = c.occurrence }, IncSearch = { bg = c.search }, CurSearch = { bg = c.search },
  Substitute = { bg = c.search }, MatchParen = { bg = c.bracket },
  QuickFixLine = { bg = c.selection }, Title = { fg = c.keyword },
  Directory = { fg = c.blue }, Question = { fg = c.cyan }, MoreMsg = { fg = c.success },
  ModeMsg = { fg = c.ui }, MsgArea = { fg = c.ui, bg = c.bg }, MsgSeparator = { bg = c.panel },
  ErrorMsg = { fg = c.error }, WarningMsg = { fg = c.keyword },
  Comment = { fg = c.comment }, Constant = { fg = c.identifier },
  String = { fg = c.string }, Character = { fg = c.string },
  Number = { fg = c.number }, Float = { fg = c.number }, Boolean = { fg = c.fg },
  Identifier = { fg = c.identifier }, Function = { fg = c.blue },
  Statement = { fg = c.keyword }, Conditional = { fg = c.keyword }, Repeat = { fg = c.keyword },
  Label = { fg = c.keyword }, Keyword = { fg = c.keyword }, Exception = { fg = c.keyword },
  Operator = { fg = c.fg }, PreProc = { fg = c.modifier }, Include = { fg = c.modifier },
  Define = { fg = c.modifier }, PreCondit = { fg = c.modifier }, Macro = { fg = c.macro },
  Type = { fg = c.type }, StorageClass = { fg = c.modifier }, Structure = { fg = c.keyword },
  Typedef = { fg = c.keyword }, Special = { fg = c.fg }, SpecialChar = { fg = c.string },
  Tag = { fg = c.keyword }, Delimiter = { fg = c.fg }, SpecialComment = { fg = c.comment },
  Debug = { fg = c.macro }, Underlined = { fg = c.blue, underline = true },
  Ignore = { fg = c.subtle }, Error = { sp = c.error, undercurl = true },
  Todo = { fg = c.macro }, Added = { fg = c.success }, Removed = { fg = c.error },
  Changed = { fg = c.blue }, DiffAdd = { bg = c.added }, DiffDelete = { bg = c.removed },
  DiffChange = { bg = c.changed }, DiffText = { bg = c.diff_text },
  SpellBad = { sp = c.error, undercurl = true }, SpellCap = { sp = c.keyword, undercurl = true },
  SpellLocal = { sp = c.cyan, undercurl = true }, SpellRare = { sp = c.blue, undercurl = true },
  LspReferenceText = { bg = c.occurrence }, LspReferenceRead = { bg = c.occurrence },
  LspReferenceWrite = { bg = c.occurrence }, LspReferenceTarget = { bg = c.occurrence },
  LspInlayHint = { fg = c.subtle, bg = c.line }, LspCodeLens = { fg = c.subtle },
  LspCodeLensSeparator = { fg = c.subtle }, LspSignatureActiveParameter = { underline = true },
}
for group, style in pairs(groups) do
  hi(group, style)
end

-- These captures are explicit so more specific defaults cannot change the roles.
local captures = {
  ['@comment'] = c.comment, ['@comment.documentation'] = c.comment,
  ['@string.documentation'] = c.comment, ['@comment.todo'] = c.macro,
  ['@comment.note'] = c.macro, ['@comment.warning'] = c.keyword, ['@comment.error'] = c.error,
  ['@variable'] = c.identifier, ['@variable.parameter'] = c.identifier,
  ['@variable.member'] = c.identifier, ['@property'] = c.identifier,
  ['@variable.builtin'] = c.number, ['@constant'] = c.identifier,
  ['@constant.builtin'] = c.fg, ['@constant.macro'] = c.macro,
  ['@module'] = c.identifier, ['@module.builtin'] = c.identifier, ['@label'] = c.identifier,
  ['@string'] = c.string, ['@string.regexp'] = c.string, ['@string.escape'] = c.string,
  ['@string.special'] = c.string, ['@string.special.symbol'] = c.string,
  ['@string.special.path'] = c.string, ['@character'] = c.string,
  ['@character.special'] = c.string, ['@boolean'] = c.fg,
  ['@number'] = c.number, ['@number.float'] = c.number,
  ['@type'] = c.type, ['@type.builtin'] = c.type, ['@type.definition'] = c.type,
  ['@attribute'] = c.modifier, ['@attribute.builtin'] = c.modifier,
  ['@function'] = c.fg, ['@function.method'] = c.fg,
  ['@function.call'] = c.blue, ['@function.method.call'] = c.blue,
  ['@function.builtin'] = c.macro, ['@function.macro'] = c.macro,
  ['@constructor'] = c.type, ['@operator'] = c.fg,
  ['@keyword'] = c.keyword, ['@keyword.function'] = c.keyword,
  ['@keyword.operator'] = c.keyword, ['@keyword.modifier'] = c.modifier,
  ['@keyword.directive'] = c.modifier, ['@keyword.directive.define'] = c.modifier,
  ['@keyword.import'] = c.modifier, ['@keyword.type'] = c.keyword,
  ['@punctuation'] = c.fg, ['@punctuation.delimiter'] = c.fg,
  ['@punctuation.bracket'] = c.fg, ['@punctuation.special'] = c.fg,
  ['@tag'] = c.keyword, ['@tag.builtin'] = c.keyword, ['@tag.attribute'] = c.modifier,
  ['@tag.delimiter'] = c.fg, ['@markup.heading'] = c.keyword,
  ['@markup.heading.1'] = c.keyword, ['@markup.raw'] = c.string,
  ['@markup.raw.block'] = c.string, ['@markup.quote'] = c.dim,
  ['@markup.list'] = c.dim, ['@markup.list.checked'] = c.success,
  ['@markup.list.unchecked'] = c.dim, ['@markup.link.label'] = c.blue,
  ['@diff.plus'] = c.success, ['@diff.minus'] = c.error, ['@diff.delta'] = c.blue,
}
for group, color in pairs(captures) do
  hi(group, { fg = color })
end
for level = 2, 6 do
  hi('@markup.heading.' .. level, { fg = c.heading })
end
hi('@string.special.url', { fg = c.blue, underline = true })
hi('@markup.link', { fg = c.blue, underline = true })
hi('@markup.link.url', { fg = c.blue, underline = true })
hi('@markup.strong', {})
hi('@markup.italic', {})
hi('@markup.underline', { underline = true })
hi('@markup.strikethrough', { strikethrough = true })

-- Semantic function/method tokens use blue; builtin overrides are bronze.
local semantic = {
  type = c.type, class = c.type, struct = c.type, interface = c.type, enum = c.type,
  typeParameter = c.type, variable = c.identifier, parameter = c.identifier,
  property = c.identifier, enumMember = c.identifier, namespace = c.identifier,
  event = c.identifier, label = c.identifier, ['function'] = c.blue, method = c.blue,
  macro = c.macro, decorator = c.modifier, modifier = c.modifier,
  keyword = c.keyword, operator = c.fg, boolean = c.fg,
  number = c.number, string = c.string, regexp = c.string, comment = c.comment,
}
-- Do not let blanket modifier defaults recolor builtin types or identifiers.
for _, modifier in ipairs({ 'defaultLibrary', 'readonly', 'static', 'async', 'abstract',
  'declaration', 'definition', 'modification', 'documentation' }) do
  hi('@lsp.mod.' .. modifier, {})
end
for token, color in pairs(semantic) do
  hi('@lsp.type.' .. token, { fg = color })
  hi('@lsp.typemod.' .. token .. '.documentation', { fg = c.comment })
end
for _, token in ipairs({ 'type', 'class', 'struct', 'interface', 'enum', 'typeParameter' }) do
  hi('@lsp.typemod.' .. token .. '.defaultLibrary', { fg = c.type })
end
hi('@lsp.typemod.variable.defaultLibrary', { fg = c.number })
hi('@lsp.typemod.function.defaultLibrary', { fg = c.macro })
hi('@lsp.typemod.method.defaultLibrary', { fg = c.macro })
hi('@lsp.mod.deprecated', { strikethrough = true })

for severity, colors in pairs({
  Error = { c.error, c.error_bg }, Warn = { c.keyword, c.warning_bg },
  Info = { c.blue, c.info_bg }, Hint = { c.cyan, c.hint_bg },
  Ok = { c.success, '#26352C' },
}) do
  hi('Diagnostic' .. severity, { fg = colors[1] })
  hi('DiagnosticSign' .. severity, { fg = colors[1], bg = c.bg })
  hi('DiagnosticFloating' .. severity, { fg = colors[1], bg = c.raised })
  hi('DiagnosticVirtualText' .. severity, { fg = colors[1], bg = colors[2] })
  hi('DiagnosticVirtualLines' .. severity, { fg = colors[1] })
  hi('DiagnosticUnderline' .. severity, { sp = colors[1], undercurl = true })
end
hi('DiagnosticUnnecessary', { undercurl = true, sp = c.subtle })
hi('DiagnosticDeprecated', { strikethrough = true })

-- Conventional syntax rules and common plugin groups inherit the same roles.
local links = {
  goFunction = '@function', goFunctionCall = '@function.call', goBuiltins = '@function.builtin',
  goType = 'Type', goTypeName = 'Type', goDeclaration = 'Keyword',
  goSignedInts = 'Type', goUnsignedInts = 'Type', goFloats = 'Type', goComplexes = 'Type',
  goBoolean = 'Boolean', goConstants = 'Boolean',
  pythonFunction = '@function', pythonBuiltin = '@function.builtin',
  pythonEscape = 'String', pythonDocString = 'Comment',
  markdownH1 = 'Title', markdownCode = 'String', markdownCodeBlock = 'String',
  markdownCodeDelimiter = 'String', markdownUrl = 'Underlined', markdownLinkText = 'Underlined',
  GitSignsAdd = 'Added', GitSignsChange = 'Changed', GitSignsDelete = 'Removed',
  GitSignsAddNr = 'Added', GitSignsChangeNr = 'Changed', GitSignsDeleteNr = 'Removed',
  TelescopeNormal = 'NormalFloat', TelescopeBorder = 'FloatBorder',
  TelescopeSelection = 'Visual', TelescopeMatching = 'Keyword',
  CmpItemAbbr = 'NormalFloat', CmpItemAbbrMatch = 'Keyword', CmpItemAbbrMatchFuzzy = 'Keyword',
  CmpItemKind = 'Type', CmpItemMenu = 'Comment', CmpItemAbbrDeprecated = 'DiagnosticDeprecated',
}
for group, target in pairs(links) do
  hi(group, { link = target })
end
for level = 2, 6 do
  hi('markdownH' .. level, { fg = c.heading })
end

local ansi = {
  '#25282C', '#D49A91', '#A8CAA0', '#DDB08C', '#91ADC7', '#B8ACD4', '#91BEBB', '#E3DCD3',
  '#8295A3', '#E2ADA3', '#BEDBB6', '#E9C49D', '#ABC5DC', '#CEBEE7', '#ABD5D1', '#F0E9E1',
}
for index, color in ipairs(ansi) do
  vim.g['terminal_color_' .. (index - 1)] = color
end

-- Transparency
local transparent_groups = {
  'Normal',
  'NormalNC',
  'NormalFloat',
  'SignColumn',
  'EndOfBuffer',
  'LineNr',
  'FoldColumn',
  'VertSplit',
  'WinSeparator',
  'StatusLine',
  'StatusLineNC',
  'TabLine',
  'TabLineFill',
}

for _, group in ipairs(transparent_groups) do
  vim.api.nvim_set_hl(0, group, { bg = 'NONE' })
end
