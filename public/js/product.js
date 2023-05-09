var currentIndex = 0;

var indexs = [];

$(document).ready(function () {
    addVariantTemplate();
    $("#file-upload").dropzone({
        url: "{{ route('file-upload') }}",
        method: "post",
        addRemoveLinks: true,
        success: function (file, response) {
            //
        },
        error: function (file, response) {
            //
        }
    });
});

function addVariant(event) {
    event.preventDefault();
    addVariantTemplate();
}

function getCombination(arr, pre) {

    pre = pre || '';

    if (!arr.length) {
        return pre;
    }

    return arr[0].reduce(function (ans, value) {
        return ans.concat(getCombination(arr.slice(1), pre + value + '/'));
    }, []);
}

function updateVariantPreview() {

    var valueArray = [];

    $(".select2-value").each(function () {
        valueArray.push($(this).val());
    });

    var variantPreviewArray = getCombination(valueArray);


    var tableBody = '';

    $(variantPreviewArray).each(function (index, element) {
        tableBody += `<tr>
                        <th>
                                        <input type="hidden" name="product_preview[${index}][variant]" value="${element}">
                                        <span class="font-weight-bold">${element}</span>
                                    </th>
                        <td>
                                        <input type="text" class="form-control" value="0" name="product_preview[${index}][price]" required>
                                    </td>
                        <td>
                                        <input type="text" class="form-control" value="0" name="product_preview[${index}][stock]">
                                    </td>
                      </tr>`;
    });

    $("#variant-previews").empty().append(tableBody);
}

function addVariantTemplate() {

    $("#variant-sections").append(`<div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="">Option</label>
                                        <select id="select2-option-${currentIndex}" data-index="${currentIndex}" name="product_variant[${currentIndex}][option]" class="form-control custom-select select2 select2-option">
                                            <option value="1">
                                                Color
                                            </option>
                                            <option value="2">
                                                Size
                                            </option>
                                            <option value="6">
                                                Style
                                            </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="form-group">
                                        <label class="d-flex justify-content-between">
                                            <span>Value</span>
                                            <a href="#" class="remove-btn" data-index="${currentIndex}" onclick="removeVariant(event, this);">Remove</a>
                                        </label>
                                        <select id="select2-value-${currentIndex}" data-index="${currentIndex}" name="product_variant[${currentIndex}][value][]" class="select2 select2-value form-control custom-select" multiple="multiple">
                                        </select>
                                    </div>
                                </div>
                            </div>`);

    $(`#select2-option-${currentIndex}`).select2({placeholder: "Select Option", theme: "bootstrap4"});

    $(`#select2-value-${currentIndex}`)
        .select2({
            tags: true,
            multiple: true,
            placeholder: "Type tag name",
            allowClear: true,
            theme: "bootstrap4"

        })
        .on('change', function () {
            updateVariantPreview();
        });

    indexs.push(currentIndex);

    currentIndex = (currentIndex + 1);

    if (indexs.length >= 3) {
        $("#add-btn").hide();
    } else {
        $("#add-btn").show();
    }
}

function removeVariant(event, element) {

    event.preventDefault();

    var jqElement = $(element);

    var position = indexs.indexOf(jqElement.data('index'))

    indexs.splice(position, 1)

    jqElement.parent().parent().parent().parent().remove();

    if (indexs.length >= 3) {
        $("#add-btn").hide();
    } else {
        $("#add-btn").show();
    }

    updateVariantPreview();
}

