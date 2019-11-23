function showSendMailForm(){
    $('#MessageModal .registerBox').fadeOut('fast',function(){
        $('.loginBox').fadeIn('fast');
        $('.register-footer').fadeOut('fast',function(){
            $('.login-footer').fadeIn('fast');    
        });
        
        $('.modal-title').html('Login with');
    });       
     $('.error').removeClass('alert alert-danger').html(''); 
}

function showSendMail(){
    showSendMailForm();
    setTimeout(function(){
        $('#MessageModal').modal('show');    
    }, 230);
    
}