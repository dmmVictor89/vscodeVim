-- wezterm_panel.lua

local wezterm = require("wezterm")

local M = {}

-- InputSelector에 사용할 선택지 목록 (id와 label만 포함)
M.selector_choices = {
  {
    id = "ssh_eContract", -- 고유 ID
    label = "🖥️  [dev] eContract, wholeSale(192.168.20.8)",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    id = "dev_active_ssh_nxcomm", -- 고유 ID
    label = "🖥️  [dev] active_nxcomm(192.168.10.26)",
  },
  {
    id = "dev_active_ssh_agent", -- 고유 ID
    label = "🖥️  [dev] active_agent(192.168.10.26)",
  },
  {
    id = "dev_active_ssh_lordsystem_active", -- 고유 ID
    label = "🖥️  [dev] active_LordSystem(192.168.10.26)",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    id = "dev_standby_ssh_nxcomm", -- 고유 ID
    label = "🖥️  [dev] active_nxcomm(192.168.10.27)",
  },
  {
    id = "dev_standby_ssh_agent", -- 고유 ID
    label = "🖥️  [dev] standby_agent(192.168.10.27)",
  },
  {
    id = "dev_standby_ssh_lordsystem_standby", -- 고유 ID
    label = "🖥️  [dev] standby_LordSystem(192.168.10.27)",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  -- PRD
  -- --------------------------------------------------------------------------------------------------------------------------------
  
  {
    id = "prd_active_ssh_nxcomm", -- 고유 ID
    label = "🖥️  [prd] active_nxcomm(192.168.10.13)",
  },
  {
    id = "prd_active_ssh_agent", -- 고유 ID
    label = "🖥️  [prd] active_agent(192.168.10.13)",
  },
  {
    id = "prd_active_ssh_lordsystem", -- 고유 ID
    label = "🖥️  [prd] active_LordSystem(192.168.10.13)",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    id = "prd_standby_ssh_nxcomm", -- 고유 ID
    label = "🖥️  [prd] active_nxcomm(192.168.10.14)",
  },
  {
    id = "prd_standby_ssh_agent", -- 고유 ID
    label = "🖥️  [prd] standby_agent(192.168.10.14)",
  },
  {
    id = "prd_standby_ssh_lordsystem_standby", -- 고유 ID
    label = "🖥️  [prd] standby_LordSystem(192.168.10.14)",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    id = "ssh_snlnas", -- 고유 ID
    label = "🖥️  snlnas (183.98.219.170)", -- 사용자에게 보여줄 레이블
  },
  -- 다른 서버 정보도 유사하게 추가 (고유 id 부여)
  -- {
  --   id = "ssh_staging",
  --   label = "🔧  staging",
  -- },
  -- {
  --   id = "ssh_prod",
  --   label = "🌐  prod",
  -- },
}

-- ID를 실제 명령어 인자(args)와 매핑하는 테이블
M.commands_by_id = {
    ssh_eContract                  = { "ssh", "devec" },
    -- dev
    dev_active_ssh_agent               = { "ssh", "dev26agent" },
    dev_standby_ssh_agent              = { "ssh", "dev27agent" },

    dev_active_ssh_nxcomm              = { "ssh", "dev26nxcomm" },
    dev_standby_ssh_nxcomm             = { "ssh", "dev27nxcomm" },

    dev_active_ssh_lordsystem_active   = { "ssh", "dev26lord"},
    dev_standby_ssh_lordsystem_standby = { "ssh", "dev27lord"},

    -- prd
    prd_active_ssh_agent               = { "ssh", "prd26agent" },
    prd_standby_ssh_agent              = { "ssh", "prd27agent" },

    prd_active_ssh_nxcomm              = { "ssh", "prd26nxcomm" },
    prd_standby_ssh_nxcomm             = { "ssh", "prd27nxcomm" },
    
    prd_active_ssh_lordsystem_active   = { "ssh", "prd13lord"},
    prd_standby_ssh_lordsystem_standby = { "ssh", "prd14lord"},

    ssh_snlnas                     = { "ssh", "snlnas" },
    -- ssh_lordsystem = { "ssh", "-p", "22", "lordsystem@192.168.10.26" }, -- -p 옵션 사용!
    -- 다른 항목들도 모두 -p 형식으로 수정
  -- staging = { "ssh", "admin@staging.example.com" },
  -- prod = { "ssh", "root@prod.example.com" },
  -- selector_choices에 정의된 모든 id에 대한 매핑을 여기에 추가
}

-- (기존 show_launcher_on_startup 함수는 필요에 따라 유지하거나 제거)
M.show_launcher_on_startup = function()
  -- ...
end

return M