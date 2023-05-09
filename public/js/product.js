var currentIndex = 0;
var imageCount = 0;

var indexs = [];

$(document).ready(function () {
    addVariantTemplate();
    $("#file-upload").dropzone({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        },
        type: "POST",
        url: fileUploadURL,
        addRemoveLinks: true,
        init: function () {
            var myDropzone = this;

            //Populate any existing thumbnails
            if (thumbnails) {
                for (var i = 0; i < thumbnails.length; i++) {
                    var mockFile = thumbnails[i];

                    // Call the default addedfile event handler
                    myDropzone.emit("addedfile", mockFile);

                    // And optionally show the thumbnail of the file:
                    myDropzone.emit("thumbnail", mockFile, thumbnails[i].url);

                    myDropzone.emit("complete", mockFile);

                    myDropzone.files.push(mockFile);
                    loadImage();
                }
            }

            this.on("removedfile", function (file) {
                    thumbnails.forEach(function(value, index){
                        if(value.url && value.url.length > 0){
                            if(value.name == file.name){
                                delete thumbnails[index]
                            }
                        }else{
                            if(value.name == JSON.parse(file.xhr.response).name){
                                delete thumbnails[index]
                                $.get(fileDeleteURL, { file_to_be_deleted: value.name } );
                            }

                        }
                    })
                    loadImage();
            });
        },
        success: function (file, response) {
            thumbnails.push(response);
            loadImage()
        },
        error: function (file, response) {
            return false;
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

    var witch_form = $('#edit_form').val() || 0;
    if ($("#variant-sections .select2-option").length != 0 && witch_form == 1) {
        if (currentIndex >= 3) {
            $("#add-btn").hide();
        }
        currentIndex = 1 + $("#variant-sections .select2-option").length;
        indexs.push(currentIndex);
    } else {
        $("#add-btn").show();
    }
    if(currentIndex < 4){

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

    }

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

    if (currentIndex >= 3) {
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

function loadImage()
{
    $(".media-section").empty();
    thumbnails.forEach(function(value){
        $(".media-section").append(`<input type="text" class="form-control" value="${value.name}" name="imageUpload[]">`);
    })
}
