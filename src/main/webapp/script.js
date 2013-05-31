// Variables Globales
var botonDescargar = $('#descargar');
var botonCancelar = $('#cancelar');
var cancelado = false;
var solicitudes = [];
var barraSolicitudes = $('#solicitudes');
var botonGuardar = $('#guardar');





// Codigo de boton descargar
botonDescargar.on('click', function() {
    cancelar = false;
    // Hacer get para obtener tamaño n
    $.get('/sdt-ciclo2/ControladorServlet?solicitud=descargar', function(data, status) {
        var n = data;
        post(0, n);
    }).fail(function(data, status) {
        console.log('Falla GET');
    });
});











// Codigo de boton cancelar
botonCancelar.on('click', function() {
    cancelar = true;
    progress(0, $('#progressBar'));
    solcitudes = [];
    setTimeout(function() {
        barraSolicitudes.text('');
        botonGuardar.css({'display': 'none'});
    }, 600)
});








botonGuardar.on('click', function() {
    progress(0, $('#progressBar'));
    barraSolicitudes.text('');
    botonGuardar.css({'display': 'none'});
    downloadLog(solicitudes);
    solicitudes = [];
});















function post(i, n) {
    if (cancelar) {
        // Hacer las fucniones de cancelar
        return;
    }
    if (i == n) {
        console.log();
        barraSolicitudes.text('Solicitudes descargadas: ' + i + '  Total: ' + n);
        // Generar el fichero
        botonGuardar.css({'display': 'inline'});
        return;
    }
    // Hacer post i para obtener la solicitud i-esima
    $.post('ControladorServlet?solicitud=escribir&i=' + i, i, function(data, status) {
        // console.log(data);
        // LA solicitud se debe de obtener de data
        solicitudes[i] = data;
        var porcentaje =((i + 1) / n) * 100;
        progress(parseInt(porcentaje), $('#progressBar'));

        setTimeout(function() {
            post(i + 1, n);
            barraSolicitudes.text('Solicitudes descargadas: ' + (i + 1) + '  Total: ' + n);
        }, 500);

    }).fail(function(data, status) {
        console.log('Falla post : ' + i);
    });

}












function progress(percent, $element) {
    var progressBarWidth = percent * $element.width() / 100;
    $element.find('div').
            animate({width: progressBarWidth}, 500).html(percent + "%&nbsp;");
}











function downloadLog(solicitudes) {
    var log = '';
    for (var i = 0; i < solicitudes.length; i++) {
        log = log + solicitudes[i] + '\n';
    }
    window.open('data:download/plain;charset=utf-8,' + encodeURI(log), '_blank');
}

