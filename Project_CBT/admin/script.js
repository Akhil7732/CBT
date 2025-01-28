window.onload = function() {
    const urlParams = new URLSearchParams(window.location.search);
    const tag = urlParams.get('tag');
    const cnt = urlParams.get('cnt');

    document.getElementBy('course').innerText = tag;
    document.getElementById('Questions').innerText = cnt;
};
