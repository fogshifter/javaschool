
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="jstl" %>

<!-- Custom styles for this template -->
<!--<link href="form-validation.css" rel="stylesheet">-->

<jstl:set var="contractBlocked" value=""/>
<jstl:set var="customerInfoEditable" value=""/>
<jstl:set var="actionMethod" value="POST"/>
<jstl:url var="syncInfoURL" value="/contracts/sync_contract"/>
<jstl:url var="comatibleOptionsURL" value="/tariffs/compatible/"/>
<jstl:set var="saveBtnText" value="Create"/>

<jstl:if test="${page != 'NEW_CONTRACT'}">
    <%--<jstl:set var="customerInfoEditable" value="disabled"/>--%>
    <jstl:set var="blockBtnClb" value="blockContract()"/>
    <jstl:set var="blockBtnText" value="Block"/>
    <jstl:set var="blockBtnClass" value=""/>
    <jstl:set var="saveBtnText" value="Save"/>

    <jstl:set var="actionMethod" value="PUT"/>


    <jstl:if test="${contractInfo.blocked != 0}">
        <jstl:if test="${user == 'CUSTOMER' && contractInfo.blocked == 2}">
            <jstl:set var="customerInfoEditable" value="disabled"/>
            <jstl:set var="blockBtnClb" value=""/>
        </jstl:if>
        <jstl:set var="contractBlocked" value="disabled"/>
        <jstl:set var="blockBtnText" value="Unblock"/>
        <jstl:set var="blockBtnClass" value="disabled"/>
    </jstl:if>

</jstl:if>






<form method="${actionURL}" action="<jstl:url value="/contracts/"/>" id="contractData" customerId="${contractInfo.customerId}" novalidate>

<input type="hidden" name="contractId" value="${contractInfo.contractId}">
<input type="hidden" name="blocked" value="${contractInfo.blocked}">

<div class = "row">
    <h4 class = "col-md-4">Customer info</h4>
</div>
<%--<form class="needs-validation" novalidate>--%>
<%--<form method="POST" onsubmit="javascript:void(0);" id="contractData" class="needs-validation" novalidate>--%>
    <div class="row">
        <div class="col-md-7 order-md-1">
            <%--<form class="needs-validation" novalidate>--%>
            <div class="form-group row">
                <label for="firstName" class="col-3 col-form-label">First name</label>
                <div class="col-9">
                    <input class="form-control" type="text" id="firstName" name="firstName" value="${contractInfo.firstName}" ${customerInfoEditable}>
                </div>
            </div>
            <div class="form-group row">
                <label for="lastName" class="col-3 col-form-label">Last name</label>
                <div class="col-9">
                    <input type="text" class="form-control" id="lastName" name="lastName" value="${contractInfo.lastName}" ${customerInfoEditable}>
                </div>
            </div>
            <div class="form-group row">
                <label for="birthDate" class="col-3 col-form-label">Date of birth</label>
                <div class="col-9">
                    <input type="text" class="form-control" id="birthDate" name="birthDate" value="${contractInfo.birthDate}" ${customerInfoEditable}>
                </div>
            </div>
            <div class="form-group row">
                <label for="email" class="col-3 col-form-label">Phone</label>
                <div class="col-9">
                    <input type="email" class="form-control" id="phone" name="phone" value="${contractInfo.phone}" ${customerInfoEditable}>
                </div>
            </div>
            <div class="form-group row">
                <label for="email" class="col-3 col-form-label">Email</label>
                <div class="col-9">
                    <input type="email" class="form-control" id="email" name="email" value="${contractInfo.email}" ${customerInfoEditable}>
                </div>
            </div>
            <div class="form-group row">
                <label for="address" class="col-3 col-form-label">Passport Data</label>
                <div class="col-9">
                    <input type="text" class="form-control" id="passportData" name="passportData" value="${contractInfo.passportData}" ${customerInfoEditable}>
                </div>
            </div>
            <div class="form-group row">
                <label for="address" class="col-3 col-form-label">Address</label>
                <div class="col-9">
                    <input type="text" class="form-control" id="address" name="address" value="${contractInfo.address}" ${customerInfoEditable}>
                </div>
            </div>

            <%--</form>--%>
        </div>

        <%--<div class="col-md-5 order-md-2" id="tariffs_accordion">--%>
        <div class="col-md-5 order-md-2" id="contract_accordion">
            <%--<form method="POST" onsubmit="javascript:void(0);" id="contractData" customerId="${contractInfo.customerId}" novalidate>--%>
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link active show" data-toggle="tab" href="#tariffs">Tariffs</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#options">Options</a>
                    </li>
                </ul>
                <div id="myTabContent" class="tab-content pre-scrollable" style="height: 315px">
                    <div class="tab-pane fade active show" id="tariffs">
                        <jstl:forEach var="tariff" items="${tariffs}">

                            <jstl:set var="compatOptionCardId" value="collapse_tariff_${tariff.id}"/>
                            <jstl:set var="compatOptionHeadId" value="t_head_${tariff.id}"/>
                            <jstl:set var="tariffChecked" value="${customerInfoEditable}"/>
                            <jstl:if test="${tariff.id == contractInfo.tariffId}">
                                <jstl:set var="tariffChecked" value = "checked ${customerInfoEditable}"/>
                            </jstl:if>

                            <div class="card border-light mb-2 mr-2">
                                <div class="card-header d-flex justify-content-between lh-condensed" id="${compatOptionHeadId}">
                                    <h5 class="mb-0">
                                        <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#${compatOptionCardId}" area-expanded="false" aria-controls="${compatOptionCardId}">
                                                ${tariff.name}
                                        </button>
                                    </h5>

                                    <div class="custom-control custom-radio">
                                        <input type="radio" id="tar_id_${tariff.id}" name="tariffId" value="${tariff.id}" class="custom-control-input" ${tariffChecked} ${customerInfoEditable}>
                                        <label class="custom-control-label" for="tar_id_${tariff.id}"></label>
                                    </div>
                                </div>

                                <div id="${compatOptionCardId}" class="collapse" aria-labelledby="${compatOptionHeadId}" data-parent="#contract_accordion">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                                            <span>Price:</span>
                                            <span>$${tariff.price}</span>
                                        </li>
                                    </ul>
                                        <%--<div id="${t_card_id}" class="collapse" aria-labelledby="${t_head_id}" data-parent="#contract_accordion">--%>
                                    <div class="card-body">
                                            ${tariff.description}
                                    </div>
                                </div>
                            </div>

                        </jstl:forEach>
                    </div>
                    <div class="tab-pane fade" id="options">
                        <jstl:forEach var="option" items="${options}">

                            <jstl:set var="optionAttrs" value="${customerInfoEditable}"/>

                            <jstl:forEach var="contractOptionId" items="${contractInfo.optionIds}">
                                <jstl:if test="${contractOptionId == option.id}">
                                    <jstl:set var="optionAttrs" value = "checked ${customerInfoEditable}"/>
                                </jstl:if>
                            </jstl:forEach>

                            <jstl:import url="option_card.jsp">
                                <jstl:param name="optionCardId" value="collapse_option_${option.id}" />
                                <jstl:param name="optionCardHeadId" value="o_head_${option.id}" />
                                <jstl:param name="cardOptionId" value="${option.id}" />
                                <jstl:param name="cardOptionName" value="${option.name}" />
                                <jstl:param name="cardOptionDescription" value="${option.description}" />
                                <jstl:param name="cardOptionPrice" value="${option.price}" />
                                <jstl:param name="optionInputName" value="optionIds" />
                                <jstl:param name="optionCardAttrs" value="${optionAttrs}" />

                            </jstl:import>

                        </jstl:forEach>
                    </div>
                </div>
                <%--<button class="btn btn-primary btn-lg btn-block mt-5" type="button" onclick="saveContract()">Save</button>--%>
            <%--<input type="hidden" name="contractId" value="${contractInfo.contractId}">--%>

            <%--</form>--%>
        </div>
    </div>

<div class="row justify-content-md-end">
    <jstl:if test="${page != 'NEW_CONTRACT'}">
        <div class="col-5">

            <button class="btn btn-primary btn-lg btn-block ${blockButtonClass}" type="button" onclick="${blockBtnClb}">${blockBtnText}</button>
        </div>
    </jstl:if>

    <div class="col-5">
        <button class="btn btn-primary btn-lg btn-block" type="button" onclick="${saveBtnClb}">${saveBtnText}</button>
    </div>
</div>

</form>
<!--<script>
// Example starter JavaScript for disabling form submissions if there are invalid fields
(function() {
'use strict';

window.addEventListener('load', function() {
// Fetch all the forms we want to apply custom Bootstrap validation styles to
var forms = document.getElementsByClassName('needs-validation');

// Loop over them and prevent submission
var validation = Array.prototype.filter.call(forms, function(form) {
form.addEventListener('submit', function(event) {
if (form.checkValidity() === false) {
event.preventDefault();
event.stopPropagation();
}
form.classList.add('was-validated');
}, false);
});
}, false);
})();
</script>-->

<script>

    function blockContract() {
        contractData = $('#contractData').serializeObject()
        // contractData.blocked =
    }

    function updateOptions(options) {
        console.log(options)

        var optionsEl = $('#options')
        optionsEl.empty()

        options.forEach(function(option){
            var optionCheckboxAttrs = '${customerInfoEditable}'
            var optionCardIdPrefix = 'collapse_option_'
            var optionCardHeadIdPrefix = 'o_head_'
            var optionInputName = 'optionIds'

            getOptionCard(optionCardIdPrefix, optionCardHeadIdPrefix, optionInputName, optionCheckboxAttrs, option).appendTo(optionsEl)
        })
    }

    $('#contractData :input').change(function() {

        <%--<jstl:if test="${user == 'CUSTOMER'}">--%>
            <%--var url = '<jstl:url value="/customer/sync_contract_info"/>'--%>
        <%--</jstl:if>--%>
        <%--<jstl:if test="${user == 'MANAGER'}">--%>
            <%--var url = '<jstl:url value="/manager/sync_contract_info"/>'--%>
        <%--</jstl:if>--%>

        <jstl:if test="${page == 'NEW_CONTRACT'}">
            var url = '${syncInfoURL}'

            var formData = $('#contractData').serializeObject()
            callREST(url, formMethod.attr('method'), JSON.stringify(formData), updateOptions)

        </jstl:if>
        <jstl:if test="${page != 'NEW_CONTRACT'}">

            var url = '${comatibleOptionsURL}'

            var tariff = $('#tariffs :input:checked').val()
            callREST(url + tariff, 'GET', null, updateOptions)
            // formData = $('#contractData').serializeObject()

        </jstl:if>

        <%--url = '${syncInfoURL}'--%>

        <%--sendForm($('#contractData'), url, function(options, status) {--%>
            <%--$('#options :checkbox').each(function(idx, input){--%>

                <%--$(input).removeAttr('checked')--%>

                <%--options.forEach(function(option) {--%>
                    <%--if(('opt_id_' + option['id']) == $(input).attr('id')) {--%>
                        <%--$(input).attr('checked', '')--%>
                    <%--}--%>
                <%--})--%>
            <%--})--%>
        <%--})--%>
    })


    <%--$('#contractData :input').change(function() {--%>

        <%--<jstl:if test="${user == 'CUSTOMER'}">--%>
            <%--var url = '<jstl:url value="/customer/sync_contract_info"/>'--%>
        <%--</jstl:if>--%>
        <%--<jstl:if test="${user == 'MANAGER'}">--%>
        <%--var url = '<jstl:url value="/manager/sync_contract_info"/>'--%>
        <%--</jstl:if>--%>


        <%--sendForm($('#contractData'), url, function(options, status) {--%>
            <%--console.log(options)--%>
            <%--/*temp = $('#options.card :first').clone()--%>
            <%--$('#options.card').remove()--%>

            <%--optionsEl = $('#options')--%>

            <%--options.forEach(function(option) {--%>

                <%--card = temp.clone();--%>
                <%--cardHeader = card.find('.card-header')--%>

                <%--var cardHeaderId = 'o_head_' + option['id']--%>
                <%--var cardId = 'collapse_option_' + option['id']--%>

                <%--cardHeader.attr('id', cardHeaderId)--%>
                <%--cardHeader.find('button')--%>
                    <%--.text(option['name'])--%>
                    <%--.attr('data-target', cardId)--%>
                    <%--.attr('aria-controls',cardId)--%>

                <%--cardHeader.find('input')--%>
                    <%--.attr('id', 'opt_id_' + option['id'])--%>
                    <%--.attr('value', option['id'])--%>

                <%--cardHeader.find('label')--%>
                    <%--.attr('for', 'opt_id_' + option['id'])--%>

                <%--card.find('#option_price')--%>
                    <%--.text(option['price'])--%>

                <%--card.find('#option_payment')--%>
                    <%--.text(option['payment'])--%>

                <%--card.find('#option_desc')--%>
                    <%--.text(option['description'])--%>

                <%--optionsEl.append(card)--%>
            <%--})*/--%>
        <%--})--%>
    <%--})--%>

    function saveContract() {
        <jstl:if test="${user == 'CUSTOMER'}">
            var url = '<jstl:url value="/customer/edit_contract"/>'
            var redirectUrl = '<jstl:url value="/customer"/>'
        </jstl:if>
        <jstl:if test="${user == 'MANAGER'}">
            var url = '<jstl:url value="/manager/edit_contract"/>'
            var redirectUrl = '<jstl:url value="/manager"/>'
        </jstl:if>

        // sendForm($('#contractData'), url, function(data) {
        //     window.location.replace(redirectUrl)
        // })
        sendForm($('#contractData'), url)
        setTimeout(function(){
            window.location.replace(redirectUrl)
        }, 1000)
    }

    <%--function syncContractInfo() {--%>
        <%--contractData = $('#contractData').serialize()--%>


        <%--$('#email').change(function(){--%>
            <%--var email = $(this).val();--%>
            <%--$.get({--%>
                <%--dataType: 'json',--%>
                <%--data : {'email': email},--%>
                <%--url : '<jstl:url value="/contract/check_email_uniqueness"/>',--%>
                <%--// http://localhost:8080/TMobile/contract/check_email_uniqueness/',--%>
                <%--success : function(response, textStatus) {--%>
                    <%--console.log(response)--%>
                <%--}--%>
            <%--})--%>
        <%--})--%>
</script>