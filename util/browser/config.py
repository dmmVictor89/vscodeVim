config.load_autoconfig()

c.editor.command = ['nvim', '{file}', '-f']  # Neovim 사용 (터미널에서 실행)


# ---------------------------------------------------------------------------------------------------------------------------------------
# password, bitwarden
# ---------------------------------------------------------------------------------------------------------------------------------------
config.bind('gr', 'spawn --userscript qute-keepassxc.cmd')

# ---------------------------------------------------------------------------------------------------------------------------------------
# Size
# ---------------------------------------------------------------------------------------------------------------------------------------
c.zoom.default = "120%"   # 기본 120% 확대

# 전체 페이지 폰트 기본 크기
c.fonts.web.size.default      = 13
c.fonts.web.size.default_fixed = 13
c.fonts.web.size.minimum       = 13

# 한국어·코딩에 맞춘 폰트 패밀리
c.fonts.web.family.serif      = "D2Coding, Hack"
c.fonts.web.family.sans_serif = "D2Coding, Hack"
c.fonts.web.family.fixed      = "D2Coding, Hack"

# 탭 폰트 (짝‑홀 동일하게)
c.fonts.tabs.selected   = "14px default_family"
c.fonts.tabs.unselected = "14px default_family"
c.fonts.statusbar       = "14px default_family"

# ---------------------------------------------------------------------------------------------------------------------------------------

# Theme
config.source('qutebrowser-theme/themes/onedark.py')
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = 'dark'  # 사이트의 다크테마 요청
c.qt.args = ['blink-settings=darkMode=2']  # kInvertBrightness (1=테스트용, 2=밝기 반전, 4=LAB 반전)
# 다크모드 토글 키 (추천)
config.bind(',d', 'config-cycle colors.webpage.darkmode.enabled')

# 사이트 별
config.set('colors.webpage.darkmode.enabled', False, 'gw.cresoty.co.kr')
config.set('colors.webpage.darkmode.enabled', False, 'http://192.168.20.6/Admin/')


# 세션 자동 저장 및 복구 활성화
# c.auto_save.session = True
c.session.lazy_restore = True    # 느리게 복원 (안정적)
# c.auto_save.interval = 60000     # 15초마다 저장

c.messages.timeout = 10000

# 클릭 시 자동 insert 모드 진입
c.input.insert_mode.auto_enter = True

# 페이지 로드 후 editable 요소 포커스 시 자동 insert
c.input.insert_mode.auto_load = True

# 비편집 요소 클릭 시 자동 normal 모드로 복귀
c.input.insert_mode.auto_leave = True

# 히스토리를 방향키로 변경
config.bind('a', 'back')
config.bind('s', 'forward')

# 스크롤
config.bind('e', 'scroll-px 0 -300')   # 위로 100px
config.bind('d', 'scroll-px 0 300')    # 아래로 100px

# 화면 위/아래 이동 추가
config.bind('E', 'scroll top')  # 맨 위
config.bind('D', 'scroll bottom')    # 맨 아래

# 새 탭(foreground)에서 열기 (기본 O)  
# config.bind('b', 'open')
config.bind('b', 'cmd-set-text --space :open')
# 현재 탭 주소 입력창 (기본 o)
config.bind('B', 'cmd-set-text --space :open -t')


# 탭 닫기
config.bind('x', 'tab-close')
config.bind('X', 'undo')

config.bind('z', 'tab-move -')           # 탭 왼쪽 이동
config.bind('v', 'tab-move +')           # 탭 오른쪽 이동

# 현재 탭 복사 (새 탭으로)
config.bind('t', 'tab-clone')     # 배경 탭으로 복사

# passthrough 모드 진입
config.bind('<Ctrl-i>', 'mode-enter passthrough')

# passthrough 모드에서 Ctrl+i로 탈출
config.bind('<Ctrl-i>', 'mode-leave', mode='passthrough')

config.unbind('<Ctrl-v>')

# 탭이동
config.bind('q', 'tab-prev')
config.bind('w', 'tab-next')

# 마지막 탭 닫기
c.tabs.last_close = 'close'


# ---------------------------------------------------------------------------------------------------------------------------------------
c.colors.tabs.selected.even.bg = "#282828"
c.colors.tabs.selected.even.fg = "#a8ff60"   # 밝은 neovim‑계열 초록
c.colors.tabs.selected.odd.bg  = "#282828"
c.colors.tabs.selected.odd.fg  = "#a8ff60"


# Hint 힌트 
config.set('fonts.hints', '18px bold "D2Coding"')
