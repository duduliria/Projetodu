const secoes = document.querySelectorAll('.main section');
secoes[0].classList.add('ativo');

function ativarSecao(event) { 
    secoes.forEach((secao) => {
        secao.classList.remove('ativo');
    }); 
    event.classList.add('ativo');   
}

secoes.forEach((secao) => {
    secao.addEventListener('click', () => ativarSecao(secao));
})