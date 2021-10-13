// an example to create a new mapping `ctrl-y`
//mapkey('<Ctrl-y>', 'Show me the money', function() {
    //Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
//});

// an example to remove mapkey `Ctrl-i`
//unmap('<Ctrl-i>');

// back and forward in history
map('H', 'S')
unmap('S')
map('L', 'D')
unmap('D')

//vim-like scrolling
map('<Ctrl-e>', 'j')
map('<Ctrl-y>', 'k')
map('<Ctrl-d>', 'd')

//cVim-like tab navigation
map('J', 'E')
map('K', 'R')
unmap('E')
unmap('R')

// new tab
map('t', 'on')
map('F', 'C')

Hints.style('font-family:JetBrains Mono; font-size: 9pt; border: solid 1px #1d1f21; color:#f0c674; background: initial; background-color: #1d1f21;');
Hints.style("border: solid 8px #C38A22;padding: 1px;background: #e39913", "text");
settings.smoothScroll = false;
settings.scrollStepSize = 140;

// set theme
settings.theme = `
.sk_theme {
    font-family: JetBrains Mono;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
// click `Save` button to make above settings to take effect.</ctrl-i></ctrl-y>
