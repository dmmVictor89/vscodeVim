-- wezterm용 vim 함수 대체 헬퍼
-- pane_tree.lua에서 vim.tbl_keys 오류 해결용

local M = {}

-- vim.tbl_keys 대체 함수
function M.tbl_keys(tbl)
    if type(tbl) ~= "table" then
        return {}
    end
    
    local keys = {}
    for k, _ in pairs(tbl) do
        table.insert(keys, k)
    end
    return keys
end

-- vim.tbl_values 대체 함수 (필요할 경우)
function M.tbl_values(tbl)
    if type(tbl) ~= "table" then
        return {}
    end
    
    local values = {}
    for _, v in pairs(tbl) do
        table.insert(values, v)
    end
    return values
end

-- vim.inspect 대체 함수 (디버깅용)
function M.inspect(obj)
    if type(obj) == "table" then
        local result = "{"
        for k, v in pairs(obj) do
            if type(v) == "string" then
                result = result .. tostring(k) .. '="' .. tostring(v) .. '", '
            else
                result = result .. tostring(k) .. "=" .. tostring(v) .. ", "
            end
        end
        result = result:gsub(", $", "") .. "}"
        return result
    else
        return tostring(obj)
    end
end

return M 