-- wezterm_panel.lua

local wezterm = require("wezterm")

local M = {}

-- InputSelector에 사용할 선택지 목록 (id와 label만 포함)
M.selector_choices = {
    
  {
    id = "ssh_scouter", -- 고유 ID
    label = "🖥️  scouter(192.168.10.15)",
  },
  
  {
    id = "ssh_jenkins", -- 고유 ID
    label = "🖥️  jenkins(192.168.10.15)",
  },

  {
    id = "ssh_eContract", -- 고유 ID
    label = "🖥️  [dev] eContract, wholeSale(192.168.20.8)",
  },
  
  -- --------------------------------------------------------------------------------------------------------------------------------
  -- DEV
  -- --------------------------------------------------------------------------------------------------------------------------------
  -- active
  -- ----------------------------------------------------o---------------------------------------------------------------------------
  {
    id = "ssh_root", -- 고유 ID
    label = "🖥️  [dev] root(192.168.10.26)",
  },
  {
    id = "dev_active_ssh_nxcomm", -- 고유 ID
    label = "🖥️  [dev] active_nxcomm(192.168.10.26)",
  },
  {
    id = "dev_active_ssh_agent", -- 고유 ID
    label = "🖥️  [dev] active_agent(192.168.10.26)",
  },
  {
    id = "dev_active_ssh_kpn", -- 고유 ID
    label = "🖥️  [dev] active_kpn(192.168.10.26)",
  },
  {
    id = "dev_active_ssh_lordsystem_active", -- 고유 ID
    label = "🖥️  [dev] active_LordSystem(192.168.10.26)",
  },
  {
    id = "dev_active_ssh_kis", -- 고유 ID
    label = "🖥️  [dev] active_kis(192.168.10.26)",
  },
  {
    id = "dev_active_ssh_kovan", -- 고유 ID
    label = "🖥️  [dev] active_kovan(192.168.10.26)",
  },
  {
    id = "dev_active_ssh_nice", -- 고유 ID
    label = "🖥️  [dev] active_nice(192.168.10.26)",
  },
  {
    id = "dev_active_ssh_kicc", -- 고유 ID
    label = "🖥️  [dev] active_kicc(192.168.10.26)",
  },
  {
    id = "dev_active_ssh_ksnet", -- 고유 ID
    label = "🖥️  [dev] active_ksnet(192.168.10.26)",
  },
  {
    id = "dev_active_ssh_shinhan_bank", -- 고유 ID
    label = "🖥️  [dev] active_shinhan-bank(192.168.10.26)",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    label = "=========================================================================================================",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  -- standby
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    id = "dev_standby_ssh_nxcomm", -- 고유 ID
    label = "🖥️  [dev] standby_nxcomm(192.168.10.27)",
  },
  {
    id = "dev_standby_ssh_agent", -- 고유 ID
    label = "🖥️  [dev] standby_agent(192.168.10.27)",
  },
  {
    id = "dev_standby_ssh_kpn", -- 고유 ID
    label = "🖥️  [dev] standby_kpn(192.168.10.27)",
  },
  {
    id = "dev_standby_ssh_lordsystem_standby", -- 고유 ID
    label = "🖥️  [dev] standby_LordSystem(192.168.10.27)",
  },
  {
    id = "dev_standby_ssh_kis", -- 고유 ID
    label = "🖥️  [dev] standby_kis(192.168.10.27)",
  },
  {
    id = "dev_standby_ssh_kovan", -- 고유 ID
    label = "🖥️  [dev] standby_kovan(192.168.10.27)",
  },
  {
    id = "dev_standby_ssh_nice", -- 고유 ID
    label = "🖥️  [dev] standby_nice(192.168.10.27)",
  },
  {
    id = "dev_standby_ssh_kicc", -- 고유 ID
    label = "🖥️  [dev] standby_kicc(192.168.10.27)",
  },
  {
    id = "dev_standby_ssh_ksnet", -- 고유 ID
    label = "🖥️  [dev] standby_ksnet(192.168.10.27)",
  },
  {
    id = "dev_standby_ssh_shinhan_bank", -- 고유 ID
    label = "🖥️  [dev] standby_shinhan-bank(192.168.10.27)",
  },
  
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    label = "=========================================================================================================",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  -- PRD
  -- --------------------------------------------------------------------------------------------------------------------------------
  -- active
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
    id = "prd_active_ssh_kpn", -- 고유 ID
    label = "🖥️  [prd] active_kpn(192.168.10.13)",
  },
  {
    id = "prd_active_ssh_lordsystem", -- 고유 ID
    label = "🖥️  [prd] active_LordSystem(192.168.10.13)",
  },
  {
    id = "prd_active_ssh_kis", -- 고유 ID
    label = "🖥️  [prd] active_kis(192.168.10.13)",
  },
  {
    id = "prd_active_ssh_kovan", -- 고유 ID
    label = "🖥️  [prd] active_kovan(192.168.10.13)",
  },
  {
    id = "prd_active_ssh_nice", -- 고유 ID
    label = "🖥️  [prd] active_nice(192.168.10.13)",
  },
  {
    id = "prd_active_ssh_kicc", -- 고유 ID
    label = "🖥️  [prd] active_kicc(192.168.10.13)",
  },
  {
    id = "prd_active_ssh_ksnet", -- 고유 ID
    label = "🖥️  [prd] active_ksnet(192.168.10.13)",
  },
  {
    id = "prd_active_ssh_shinhan_bank", -- 고유 ID
    label = "🖥️  [prd] active_shinhan-bank(192.168.10.13)",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    label = "=========================================================================================================",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  -- standby
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    id = "prd_standby_ssh_nxcomm", -- 고유 ID
    label = "🖥️  [prd] standby_nxcomm(192.168.10.14)",
  },
  {
    id = "prd_standby_ssh_agent", -- 고유 ID
    label = "🖥️  [prd] standby_agent(192.168.10.14)",
  },
  {
    id = "prd_standby_ssh_kpn", -- 고유 ID
    label = "🖥️  [prd] standby_kpn(192.168.10.13)",
  },
  {
    id = "prd_standby_ssh_lordsystem_standby", -- 고유 ID
    label = "🖥️  [prd] standby_LordSystem(192.168.10.14)",
  },
  {
    id = "prd_standby_ssh_kis", -- 고유 ID
    label = "🖥️  [prd] standby_kis(192.168.10.14)",
  },
  {
    id = "prd_standby_ssh_kovan", -- 고유 ID
    label = "🖥️  [prd] standby_kovan(192.168.10.14)",
  },
  {
    id = "prd_standby_ssh_nice", -- 고유 ID
    label = "🖥️  [prd] standby_nice(192.168.10.14)",
  },
  {
    id = "prd_standby_ssh_kicc", -- 고유 ID
    label = "🖥️  [prd] standby_kicc(192.168.10.14)",
  },
  {
    id = "prd_standby_ssh_ksnet", -- 고유 ID
    label = "🖥️  [prd] standby_ksnet(192.168.10.14)",
  },
  {
    id = "prd_standby_ssh_shinhan_bank", -- 고유 ID
    label = "🖥️  [prd] standby_shinhan-bank(192.168.10.14)",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    label = "=========================================================================================================",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    id = "dev_legacy", -- 고유 ID
    label = "🖥️  [dev] legacy_procServer(192.168.10.53)",
  },
  {
    id = "prd_legacy", -- 고유 ID
    label = "🖥️  [prd] legacy_procServer(192.168.10.10)",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    id = "prd_DB1_ssh", -- 고유 ID
    label = "🖥️  [prd] DB1_pharmpay(192.168.10.31)",
  },
  {
    id = "prd_db2_ssh", -- 고유 ID
    label = "🖥️  [prd] DB2_pharmpay(192.168.10.32)",
  },
  -- --------------------------------------------------------------------------------------------------------------------------------
  {
    label = "=========================================================================================================",
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
    
    ssh_root                       = { "ssh", "devroot" },
    ssh_scouter                    = { "ssh", "scouter" },
    ssh_jenkins                    = { "ssh", "jenkins" },

    ssh_eContract                  = { "ssh", "devec" },
    -- dev
    dev_active_ssh_nxcomm              = { "ssh", "dev26nxcomm" },
    dev_standby_ssh_nxcomm             = { "ssh", "dev27nxcomm" },
    
    dev_active_ssh_agent               = { "ssh", "dev26agent" },
    dev_standby_ssh_agent              = { "ssh", "dev27agent" },

    dev_active_ssh_lordsystem_active   = { "ssh", "dev26lord"},
    dev_standby_ssh_lordsystem_standby = { "ssh", "dev27lord"},
    
    dev_active_ssh_kpn                 = { "ssh", "dev26kpn" },
    dev_standby_ssh_kpn                = { "ssh", "dev27kpn" },
    
    -- kis
    dev_active_ssh_kis                 = { "ssh", "dev26kis" },
    dev_standby_ssh_kis                = { "ssh", "dev27kis" },
    
    -- kovan
    dev_active_ssh_kovan               = { "ssh", "dev26kovan" },
    dev_standby_ssh_kovan              = { "ssh", "dev27kovan" },
    
    -- nice
    dev_active_ssh_nice                = { "ssh", "dev26nice" },
    dev_standby_ssh_nice               = { "ssh", "dev27nice" },
    
    -- kicc
    dev_active_ssh_kicc                = { "ssh", "dev26kicc" },
    dev_standby_ssh_kicc               = { "ssh", "dev27kicc" },
    
    -- ksnet
    dev_active_ssh_ksnet               = { "ssh", "dev26ksnet" },
    dev_standby_ssh_ksnet              = { "ssh", "dev27ksnet" },
    
    -- shinhan-bank
    dev_active_ssh_shinhan_bank        = { "ssh", "dev26shinhan-bank" },
    dev_standby_ssh_shinhan_bank       = { "ssh", "dev27shinhan-bank" },
    
    dev_legacy                         = { "ssh", "dev53"},

    -- prd
    prd_active_ssh_agent               = { "ssh", "prd13agent" },
    prd_standby_ssh_agent              = { "ssh", "prd14agent" },
    
    prd_active_ssh_kpn                 = { "ssh", "prd13kpn" },
    prd_standby_ssh_kpn                = { "ssh", "prd14kpn" },

    prd_active_ssh_nxcomm              = { "ssh", "prd13nxcomm" },
    prd_standby_ssh_nxcomm             = { "ssh", "prd14nxcomm" },
    
    prd_active_ssh_lordsystem          = { "ssh", "prd13lord"},
    prd_standby_ssh_lordsystem         = { "ssh", "prd14lord"},
    
    -- kis
    prd_active_ssh_kis                 = { "ssh", "prd13kis" },
    prd_standby_ssh_kis                = { "ssh", "prd14kis" },
    
    -- kovan
    prd_active_ssh_kovan               = { "ssh", "prd13kovan" },
    prd_standby_ssh_kovan              = { "ssh", "prd14kovan" },
    
    -- nice
    prd_active_ssh_nice                = { "ssh", "prd13nice" },
    prd_standby_ssh_nice               = { "ssh", "prd14nice" },
    
    -- kicc
    prd_active_ssh_kicc                = { "ssh", "prd13kicc" },
    prd_standby_ssh_kicc               = { "ssh", "prd14kicc" },
    
    -- ksnet
    prd_active_ssh_ksnet               = { "ssh", "prd13ksnet" },
    prd_standby_ssh_ksnet              = { "ssh", "prd14ksnet" },
    
    -- shinhan-bank
    prd_active_ssh_shinhan_bank        = { "ssh", "prd13shinhan-bank" },
    prd_standby_ssh_shinhan_bank       = { "ssh", "prd14shinhan-bank" },

    prd_legacy                         = { "ssh", "prd10"},

    prd_DB1_ssh                        = { "ssh", "prd31db"},
    prd_db2_ssh                        = { "ssh", "prd32db"},
    
    ssh_snlnas                     = { "ssh", "snlnas" },
    -- ssh_lordsystem = { "ssh", "-p", "22", "lordsystem@192.168.10.26" }, -- -p 옵션 사용!
    -- 다른 항목들도 모두 -p 형식으로 수정
  -- staging = { "ssh", "admin@staging.example.com" },
  -- prod = { "ssh", "root@prod.example.com" },
  -- selector_choices에 정의된 모든 id에 대한 매핑을 여기에 추가
}

-- (기존 show_launcher_on_startup 함수는 필요에 따라 유지하거나 제거)
-- M.show_launcher_on_startup = function()
--   -- ...
-- end

return M