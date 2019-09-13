module.exports = {
  config: {
    fontSize: 13,
    fontFamily: 'Ubuntu Mono Derivative Powerline, Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',
    cursorColor: 'rgba(255,9,255,0.8)',
    cursorShape: 'BLOCK',
    foregroundColor: '#dedee6',
    backgroundColor: '#16161b',
    borderColor: '#1c1c1c',

    // custom css to embed in the main window
    css: `
      .splitpane_divider {
        display: none;
      }
      .hyper-spotify-overlay + div {
        position: absolute !important;
        z-index: 999;
      }
      .hyper_main {
        z-index: 999;
      }
      .hyper_main:after {
        content: "";
        position: absolute;
        right: 0;
        background: radial-gradient(at center bottom, rgba(79, 218, 141, 0.1) 0%, rgba(64, 150, 238, 0) 60%) !important;
        bottom: 0;
        top: 70vh;
        height: unset;
        width: 300vh;
        left: 50%;
        display: block;
        transform: translateX(-50%);
      }
      .hyper_main:before {
        content: "";
        display: block;
        z-index: 999;
        background: url(https://s3.gifyu.com/images/nyan.gif);
        //background: url(https://thumbs.gfycat.com/NiceImmaterialCrownofthornsstarfish-max-1mb.gif);
        //background: url(https://i.imgur.com/j51uHm1.gif);
        //background: url(https://i.kym-cdn.com/photos/images/original/001/187/255/5e9.gif);
        background-size: cover;
        width: 100px;
        height: 100px;
        position: absolute;
        font-size: 12px;
        font-weight: bold;
        right: 0;
        bottom: 0;
      }
      [data-reactroot] > div:last-child {
        background: linear-gradient(to top, rgb(35, 91, 99) -100%, transparent 90%) !important;
        // background: rgb(21, 34, 37) !important;
        font-size: 10px !important;
        font-weight: 100 !important;
        padding-top: 22px !important;
        padding-bottom: 4px !important;
        height: 54px !important;
        //animation: wow 2s linear infinite;
      }
      [data-reactroot] > div:last-child div {
        color: #fff !important;
        opacity: .9;
      }
      [data-reactroot] > div:last-child svg * {
        fill: #fff !important;
      }
      .tabs_title span i:before, .tab_textInner span i:before {
        font-size: 20px;
        color: #b90d72;
      }
      .tab_active {
        border-bottom: 1px solid #13c7fe !important;
      }
      .hyper-spotify {
        opacity: 1 !important;
        bottom: 17px !important;
      }
      .hyper-spotify .hyper-spotify-overlay {
        background: linear-gradient(to top, #00ffd0, transparent) !important;
      }
      .hyper-spotify .hyper-spotify-icon {
        background-color: #00ff89 !important;
      }
      .hyper-spotify-icon-pause, .hyper-spotify-icon-play {
        width: 21px !important;
        height: 20px !important;
        margin-left: 3px !important;
        margin-right: 3px !important;
      }
      @keyframes wow {
        from { filter: hue-rotate(0deg) }
        to { filter: hue-rotate(360deg) }
      }
    `,

    // custom css to embed in the termial window
    //termCSS: `
    //  x-row {
    //    line-height: 13px;
    //    padding-top: 0px;
    //  }
    //`,
    showHamburgerMenu: '',
    showWindowControls: '',
    padding: '2px 0 18px 0',
    colors: {
      black        : '#000000',
      red          : '#E52F3B',
      green        : '#008105',
      yellow       : '#D67E30',
      blue         : '#2A387F',
      magenta      : '#E140FE',
      cyan         : '#59EAFB',
      white        : '#FCFEEE',
      lightBlack   : '#666666',
      lightRed     : '#DE2D23',
      lightGreen   : '#4ed660',
      lightYellow  : '#E0E424',
      lightBlue    : '#5CABFB',
      lightMagenta : '#E03CDF',
      lightCyan    : '#5DA2D1',
      lightWhite   : '#E0DFE0'
    },
    shell: '/bin/zsh',
    shellArgs: ['--login'],
    env: {},
    bell: 'SOUND',
    copyOnSelect: false,

    // URL to custom bell
    // bellSoundURL: 'http://www.myinstants.com/media/sounds/birl.mp3',

    hyperCustomTouchbar: [
      { label: 'Clear', command: 'clear', backgroundColor: '#d13232' },
      //{ command: 'code .', esc: true, icon: '/tmp/vscode.png' },
      { label: 'VSCode', command: 'code .', esc: true },
      {
        //icon: '/tmp/git.png',
        //iconPosition: 'right',
        label: 'Git',
        options: [
          { label: 'status 🔎', command: 'git status', esc: true },  
          { label: 'add ✏️', command: 'git add ', prompt: true, esc: true },
          { label: 'commit 🔥', command: 'git commit -m ', prompt: true, esc: true },
          { label: 'push 🚀', command: 'git push origin ', prompt: true, esc: true },
          { label: 'pull 🌵', command: 'git pull origin ', prompt: true, esc: true },
        ]
      },
      {
        //icon: '/tmp/npm.png',
        //iconPosition: 'right',
        label: 'npm',
        options: [
          { label: 'start 🏁', command: 'npm start', esc: true },  
          { label: 'install 📦', command: 'git install ', prompt: true, esc: true },
          { label: 'run 🤖', command: 'git run ', prompt: true, esc: true }
        ]
      }
    ]
  },
  plugins: ["hyper-tab-icons", // "hyper-spotify",
  "hyper-blink", "hypercwd", "hyperlayout", "hypergravity", "hyperline", "hyper-custom-touchbar"],
  localPlugins: [],
};
