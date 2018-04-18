var AjaxManager = {
    URL: '',
    Method: '',    
    Call: function (requestData, CallBackResponse) {
        SendRequest(this.URL + this.Method, this.LoadingMessage, requestData, CallBackResponse);
    }
}

function SendRequest(requestURL, loadingMessage, requestData, callBackResponse) {
    $.ajax({
        async: true,
        type: requestData == null ? "GET" : "POST",
        url: requestURL,
        cache: false,
        contentType: "application/json; charset=utf-8",
        data: requestData != null ? JSON.stringify(requestData) : null,
        dataType: "json",
        //crossDomain: true,
        beforeSend: function (xhr) {
        },
        success: function (response, textStatus, jqXHR) {      
            callBackResponse(response);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR + "-" + textStatus + "-" + errorThrown);
        }
    });
}