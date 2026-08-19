local MODE_INDICATORS = {
  'content',
  'string',
  'code',
  'math',
  'raw_span',
}

local M = {}

--- See https://github.com/tree-sitter/tree-sitter/discussions/3716
--- Somewhat plagiarised from https://github.com/nvim-treesitter/nvim-treesitter-context/blob/master/lua/treesitter-context/context.lua#L12
--- @param bufnr integer | nil
--- @return TSNode[]?
--- @diagnostic disable-next-line
local function get_ancestors_curr_node(bufnr)
  local tree = vim.treesitter.get_parser(bufnr):parse(nil)[1]
  local ret = {} --- @type TSNode[]

  if not tree then
    return
  end

  local p = tree:root() --- @type TSNode?
  local node = vim.treesitter.get_node()

  if not node then
    return
  end

  while p do
    ret[#ret+1] = p
    --- @diagnostic disable-next-line:undefined-field added in 0.11
    p = p:child_with_descendant(node) --- @type TSNode?
  end

  return ret
end

---@param mode 'content' | 'string' | 'code' | 'math'
---@return boolean
local function isInsideMode(mode)
  local ancestors = get_ancestors_curr_node(0)

  for i = #ancestors, 1, -1 do
    --- @diagnostic disable-next-line:need-check-nil
    local node_type = ancestors[i]:type()

    if node_type == mode then
      return true
    elseif require('utils.utils').array_includes(MODE_INDICATORS, node_type) then
      return false
    end
  end

  if not mode == 'content' then
    return false
  else
    return true
  end
end

---Check whether Treesitter Node is inside a Math node
---@return boolean
function M.isInsideMath()
  return isInsideMode('math')
end

---Check whether Treesitter Node is inside a Code node
---@return boolean
function M.isInsideCode()
  return isInsideMode('code')
end

---Check whether Treesitter Node is inside a Markup node
---@return boolean
function M.isInsideMarkup()
  return isInsideMode('content')
end

return M
