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
  -- --------------------------------------------------------------------------------------------------------------------------------
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
    id = "dev_active_ssh_lordsystem", -- 고유 ID
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
    id = "dev_standby_ssh_lordsystem", -- 고유 ID
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
    id = "prd_standby_ssh_lordsystem", -- 고유 ID
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
    
    ssh_root                       = { "ssh", "-t", "devroot", "'bash --rcfile ~/.mybash -i'" },
    ssh_scouter                    = { "ssh", "-t", "scouter", "'bash --rcfile ~/.mybash -i'" },
    ssh_jenkins                    = { "ssh", "-t", "jenkins", "'bash --rcfile ~/.mybash -i'" },

    ssh_eContract                  = { "ssh", "-t", "devec", "'bash --rcfile ~/.mybash -i'" },
    -- dev
    dev_active_ssh_nxcomm              = { "ssh", "-t", "dev26nxcomm", "'bash --rcfile ~/.mybash -i'" },
    dev_standby_ssh_nxcomm             = { "ssh", "-t", "dev27nxcomm", "'bash --rcfile ~/.mybash -i'" },
    
    dev_active_ssh_agent               = { "ssh", "-t", "dev26agent", "'bash --rcfile ~/.mybash -i'" },
    dev_standby_ssh_agent              = { "ssh", "-t", "dev27agent", "'bash --rcfile ~/.mybash -i'" },

    dev_active_ssh_lordsystem          = { "ssh", "-t", "dev26lord", "'bash --rcfile ~/.mybash -i'"},
    dev_standby_ssh_lordsystem         = { "ssh", "-t", "dev27lord", "'bash --rcfile ~/.mybash -i'"},
    
    dev_active_ssh_kpn                 = { "ssh", "-t", "dev26kpn", "'bash --rcfile ~/.mybash -i'" },
    dev_standby_ssh_kpn                = { "ssh", "-t", "dev27kpn", "'bash --rcfile ~/.mybash -i'" },
    
    -- kis
    dev_active_ssh_kis                 = { "ssh", "-t", "dev26kis", "'bash --rcfile ~/.mybash -i'" },
    dev_standby_ssh_kis                = { "ssh", "-t", "dev27kis", "'bash --rcfile ~/.mybash -i'" },
    
    -- kovan
    dev_active_ssh_kovan               = { "ssh", "-t", "dev26kovan", "'bash --rcfile ~/.mybash -i'" },
    dev_standby_ssh_kovan              = { "ssh", "-t", "dev27kovan", "'bash --rcfile ~/.mybash -i'" },
    
    -- nice
    dev_active_ssh_nice                = { "ssh", "-t", "dev26nice", "'bash --rcfile ~/.mybash -i'" },
    dev_standby_ssh_nice               = { "ssh", "-t", "dev27nice", "'bash --rcfile ~/.mybash -i'" },
    
    -- kicc
    dev_active_ssh_kicc                = { "ssh", "-t", "dev26kicc", "'bash --rcfile ~/.mybash -i'" },
    dev_standby_ssh_kicc               = { "ssh", "-t", "dev27kicc", "'bash --rcfile ~/.mybash -i'" },
    
    -- ksnet
    dev_active_ssh_ksnet               = { "ssh", "-t", "dev26ksnet", "'bash --rcfile ~/.mybash -i'" },
    dev_standby_ssh_ksnet              = { "ssh", "-t", "dev27ksnet", "'bash --rcfile ~/.mybash -i'" },
    
    -- shinhan-bank
    dev_active_ssh_shinhan_bank        = { "ssh", "-t", "dev26shinhan-bank", "'bash --rcfile ~/.mybash -i'" },
    dev_standby_ssh_shinhan_bank       = { "ssh", "-t", "dev27shinhan-bank", "'bash --rcfile ~/.mybash -i'" },
    
    dev_legacy                         = { "ssh", "-t", "dev53", "'bash --rcfile ~/.mybash -i'"},

    -- prd
    prd_active_ssh_agent               = { "ssh", "-t", "prd13agent", "'bash --rcfile ~/.mybash -i'" },
    prd_standby_ssh_agent              = { "ssh", "-t", "prd14agent", "'bash --rcfile ~/.mybash -i'" },
    
    prd_active_ssh_kpn                 = { "ssh", "-t", "prd13kpn", "'bash --rcfile ~/.mybash -i'" },
    prd_standby_ssh_kpn                = { "ssh", "-t", "prd14kpn", "'bash --rcfile ~/.mybash -i'" },

    prd_active_ssh_nxcomm              = { "ssh", "-t", "prd13nxcomm", "'bash --rcfile ~/.mybash -i'" },
    prd_standby_ssh_nxcomm             = { "ssh", "-t", "prd14nxcomm", "'bash --rcfile ~/.mybash -i'" },
    
    prd_active_ssh_lordsystem          = { "ssh", "-t", "prd13lord", "'bash --rcfile ~/.mybash -i'"},
    prd_standby_ssh_lordsystem         = { "ssh", "-t", "prd14lord", "'bash --rcfile ~/.mybash -i'"},
    
    -- kis
    prd_active_ssh_kis                 = { "ssh", "-t", "prd13kis", "'bash --rcfile ~/.mybash -i'" },
    prd_standby_ssh_kis                = { "ssh", "-t", "prd14kis", "'bash --rcfile ~/.mybash -i'" },
    
    -- kovan
    prd_active_ssh_kovan               = { "ssh", "-t", "prd13kovan", "'bash --rcfile ~/.mybash -i'" },
    prd_standby_ssh_kovan              = { "ssh", "-t", "prd14kovan", "'bash --rcfile ~/.mybash -i'" },
    
    -- nice
    prd_active_ssh_nice                = { "ssh", "-t", "prd13nice", "'bash --rcfile ~/.mybash -i'" },
    prd_standby_ssh_nice               = { "ssh", "-t", "prd14nice", "'bash --rcfile ~/.mybash -i'" },
    
    -- kicc
    prd_active_ssh_kicc                = { "ssh", "-t", "prd13kicc", "'bash --rcfile ~/.mybash -i'" },
    prd_standby_ssh_kicc               = { "ssh", "-t", "prd14kicc", "'bash --rcfile ~/.mybash -i'" },
    
    -- ksnet
    prd_active_ssh_ksnet               = { "ssh", "-t", "prd13ksnet", "'bash --rcfile ~/.mybash -i'" },
    prd_standby_ssh_ksnet              = { "ssh", "-t", "prd14ksnet", "'bash --rcfile ~/.mybash -i'" },
    
    -- shinhan-bank
    prd_active_ssh_shinhan_bank        = { "ssh", "-t", "prd13shinhan-bank", "'bash --rcfile ~/.mybash -i'" },
    prd_standby_ssh_shinhan_bank       = { "ssh", "-t", "prd14shinhan-bank", "'bash --rcfile ~/.mybash -i'" },

    prd_legacy                         = { "ssh", "-t", "prd10", "'bash --rcfile ~/.mybash -i'"},

    prd_DB1_ssh                        = { "ssh", "-t", "prd31db", "'bash --rcfile ~/.mybash -i'"},
    prd_db2_ssh                        = { "ssh", "-t", "prd32db", "'bash --rcfile ~/.mybash -i'"},
    
    ssh_snlnas                     = { "ssh", "-t", "snlnas", "'bash --rcfile ~/.mybash -i'" },
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