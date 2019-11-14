"use strict";

// begin: Admin Page
var KTDatatablesSearchOptionsAdvancedSearch = function() {

    $.fn.dataTable.Api.register('column().title()', function() {
        return $(this.header()).text().trim();
    });

    var initTableContent = function() {
        var state_category = "";
        var href_category = "";
        // begin first table
        var table = $('#table_content').DataTable({
            responsive: true,
            // Pagination settings
            dom: `<'row'<'col-sm-12'tr>><'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'lp>>`,
            // read more: https://datatables.net/examples/basic_init/dom.html
            lengthMenu: [5, 10, 25, 50],
            pageLength: 10,
            language: {
                'lengthMenu': 'Display _MENU_',
            },
            searchDelay: 500,
            processing: true,
            serverSide: false,
            ajax: {
                url: '../source/content.json',
                type: 'POST',
                data: {
                    // parameters for custom backend script demo
                    columnsDef: [
                        'no', 'depot', 'vendor', 'pekerjaan', 'sifat',
                        'tanggal', 'status', 'aksi',
                    ],
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                // orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'title',
                title: 'Title',
            }, {
                data: 'category',
                title: 'Category',
                render: function(data, type, row, meta) {
                    state_category = data;
                    var category = {
                        'Daily Tips': {
                            'title': 'Daily Tips',
                            'class': 'btn-label-brand'
                        },
                        'Emergency': {
                            'title': 'Emergency',
                            'class': 'btn-label-warning'
                        },
                        'Article': {
                            'title': 'Article',
                            'class': 'btn-label-dark'
                        },
                    };
                    if (typeof category[data] === 'undefined') {
                        return '<span style="width:100%" class="btn btn-bold btn-sm btn-font-sm btn-label-danger">' + data + '</span>';
                    }
                    return '<span style="width:100%" class="btn btn-bold btn-sm btn-font-sm ' + category[data].class + '">' + category[data].title + '</span>';
                }
            }, {
                data: 'creator',
                title: 'Created By',
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    if (state_category === "Daily Tips") {
                        href_category = "content_detail_dailytips.html";
                    }
                    else if (state_category === "Emergency") {
                        href_category = "content_detail_emergency.html";
                    }
                    else if (state_category === "Article") {
                        href_category = "content_detail_article.html";
                    }
                    else {
                        href_category = "content_detail_embassy.html";
                    }
                    return `
					<button type="button" class="btn btn-clean btn-icon btn-sm btn-icon-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="flaticon-more"></i>
					</button>
					<div style="min-width:9rem;padding:5px;" class="dropdown-menu dropdown-menu-right">
					<a href="`+ href_category +`" style="margin-bottom:5px;" class="dropdown-item btn btn-secondary"> <i class="fa fa-arrow-right"></i> Details</button>&nbsp;
					<a href="#"  class="dropdown-item btn btn-secondary" id="kt_sweetalert_blacklist">  <i class="fa fa-times"></i> Blacklist</a>
                    <script>
                        $('#kt_sweetalert_blacklist').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, add to blacklist!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Blacklisted!',
                                            'Content has been added to blacklist.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }],
            initComplete: function() {
                this.api().columns().every(function() {
                    var column = this;
                    switch (column.title()) {
                        case 'Category':
                            column.data().unique().sort().each(function(d, j) {
                                $('.kt-input[data-col-index="3"]').append('<option value="' + d + '">' + d + '</option>');
                            });
                            break;
                    }
                });
            },
            columnDefs: [{
                targets: [0, 1, 2, 3, 4],
                className: 'text-center',
                orderable: false,
            }],
        });
        table.on('order.dt search.dt', function() {
            table.column(0, {
                search: 'applied',
                order: 'applied'
            }).nodes().each(function(cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
        var filter = function() {
            var val = $.fn.dataTable.util.escapeRegex($(this).val());
            table.column($(this).data('col-index')).search(val ? val : '', false, false).draw();
        };
        var asdasd = function(value, index) {
            var val = $.fn.dataTable.util.escapeRegex(value);
            table.column(index).search(val ? val : '', false, true);
        };
        $('#kt_search_content_category').on('change', function(e) {
            e.preventDefault();
            var params = {};
            $('.kt-input').each(function() {
                var i = $(this).data('col-index');
                if (params[i]) {
                    params[i] += '|' + $(this).val();
                } else {
                    params[i] = $(this).val();
                }
            });
            $.each(params, function(i, val) {
                // apply search params to datatable
                table.column(i).search(val ? val : '', false, false);
            });
            table.table().draw();
        });
        $('#kt_search_all').on('keyup', function() {
            table.search(this.value).draw();
        });
    };

    var initTableContentReported = function() {
        var state_category = "";
        var href_category = "";
        // begin first table
        var table = $('#table_content_reported').DataTable({
            responsive: true,
            // Pagination settings
            dom: `<'row'<'col-sm-12'tr>><'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'lp>>`,
            // read more: https://datatables.net/examples/basic_init/dom.html
            lengthMenu: [5, 10, 25, 50],
            pageLength: 10,
            language: {
                'lengthMenu': 'Display _MENU_',
            },
            searchDelay: 500,
            processing: true,
            serverSide: false,
            ajax: {
                url: '../source/content.json',
                type: 'POST',
                data: {
                    // parameters for custom backend script demo
                    columnsDef: [
                        'no', 'depot', 'vendor', 'pekerjaan', 'sifat',
                        'tanggal', 'status', 'aksi',
                    ],
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                // orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'title',
                title: 'Title',
            }, {
                data: 'category',
                title: 'Category',
                render: function(data, type, row, meta) {
                    state_category = data;
                    var category = {
                        'Daily Tips': {
                            'title': 'Daily Tips',
                            'class': 'btn-label-brand'
                        },
                        'Emergency': {
                            'title': 'Emergency',
                            'class': 'btn-label-warning'
                        },
                        'Article': {
                            'title': 'Article',
                            'class': 'btn-label-dark'
                        },
                    };
                    if (typeof category[data] === 'undefined') {
                        return '<span style="width:100%" class="btn btn-bold btn-sm btn-font-sm btn-label-danger">' + data + '</span>';
                    }
                    return '<span style="width:100%" class="btn btn-bold btn-sm btn-font-sm ' + category[data].class + '">' + category[data].title + '</span>';
                }
            }, {
                data: 'creator',
                title: 'Created By',
            }, {
                data: 'report',
                title: 'Reports',
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    if (state_category === "Daily Tips") {
                        href_category = "content_detail_dailytips.html";
                    }
                    else if (state_category === "Emergency") {
                        href_category = "content_detail_emergency.html";
                    }
                    else if (state_category === "Article") {
                        href_category = "content_detail_article.html";
                    }
                    else {
                        href_category = "content_detail_embassy.html";
                    }
                    return `
					<button type="button" class="btn btn-clean btn-icon btn-sm btn-icon-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="flaticon-more"></i>
					</button>
					<div style="min-width:9rem;padding:5px;" class="dropdown-menu dropdown-menu-right">
					<a href="`+ href_category +`" style="margin-bottom:5px;" class="dropdown-item btn btn-secondary"> <i class="fa fa-arrow-right"></i> Details</button>&nbsp;
					<a href="#"  class="dropdown-item btn btn-secondary" id="kt_sweetalert_blacklist">  <i class="fa fa-times"></i> Blacklist</a>
                    <script>
                        $('#kt_sweetalert_blacklist').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, add to blacklist!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Blacklisted!',
                                            'Content has been added to blacklist.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }],
            initComplete: function() {
                this.api().columns().every(function() {
                    var column = this;
                    switch (column.title()) {
                        case 'Category':
                            column.data().unique().sort().each(function(d, j) {
                                $('.kt-input[data-col-index="3"]').append('<option value="' + d + '">' + d + '</option>');
                            });
                            break;
                    }
                });
            },
            columnDefs: [{
                targets: [0, 1, 2, 3, 4, 5],
                className: 'text-center',
                orderable: false,
            }],
        });
        table.on('order.dt search.dt', function() {
            table.column(0, {
                search: 'applied',
                order: 'applied'
            }).nodes().each(function(cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
        var filter = function() {
            var val = $.fn.dataTable.util.escapeRegex($(this).val());
            table.column($(this).data('col-index')).search(val ? val : '', false, false).draw();
        };
        var asdasd = function(value, index) {
            var val = $.fn.dataTable.util.escapeRegex(value);
            table.column(index).search(val ? val : '', false, true);
        };
        $('#kt_search_content_category').on('change', function(e) {
            e.preventDefault();
            var params = {};
            $('.kt-input').each(function() {
                var i = $(this).data('col-index');
                if (params[i]) {
                    params[i] += '|' + $(this).val();
                } else {
                    params[i] = $(this).val();
                }
            });
            $.each(params, function(i, val) {
                // apply search params to datatable
                table.column(i).search(val ? val : '', false, false);
            });
            table.table().draw();
        });
        $('#kt_search_all').on('keyup', function() {
            table.search(this.value).draw();
        });
    };

    var initTableContentBlacklist = function() {
        var state_category = "";
        var href_category = "";
        // begin first table
        var table = $('#table_content_blacklist').DataTable({
            responsive: true,
            // Pagination settings
            dom: `<'row'<'col-sm-12'tr>><'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'lp>>`,
            // read more: https://datatables.net/examples/basic_init/dom.html
            lengthMenu: [5, 10, 25, 50],
            pageLength: 10,
            language: {
                'lengthMenu': 'Display _MENU_',
            },
            searchDelay: 500,
            processing: true,
            serverSide: false,
            ajax: {
                url: '../source/content.json',
                type: 'POST',
                data: {
                    // parameters for custom backend script demo
                    columnsDef: [
                        'no', 'depot', 'vendor', 'pekerjaan', 'sifat',
                        'tanggal', 'status', 'aksi',
                    ],
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                // orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'title',
                title: 'Title',
            }, {
                data: 'category',
                title: 'Category',
                render: function(data, type, row, meta) {
                    state_category = data;
                    var category = {
                        'Daily Tips': {
                            'title': 'Daily Tips',
                            'class': 'btn-label-brand'
                        },
                        'Emergency': {
                            'title': 'Emergency',
                            'class': 'btn-label-warning'
                        },
                        'Article': {
                            'title': 'Article',
                            'class': 'btn-label-dark'
                        },
                    };
                    if (typeof category[data] === 'undefined') {
                        return '<span style="width:100%" class="btn btn-bold btn-sm btn-font-sm btn-label-danger">' + data + '</span>';
                    }
                    return '<span style="width:100%" class="btn btn-bold btn-sm btn-font-sm ' + category[data].class + '">' + category[data].title + '</span>';
                }
            }, {
                data: 'creator',
                title: 'Created By',
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    if (state_category === "Daily Tips") {
                        href_category = "content_detail_dailytips.html";
                    }
                    else if (state_category === "Emergency") {
                        href_category = "content_detail_emergency.html";
                    }
                    else if (state_category === "Article") {
                        href_category = "content_detail_article.html";
                    }
                    else {
                        href_category = "content_detail_embassy.html";
                    }
                    return `<a href="`+ href_category +`" class="btn btn-sm btn-brand" style="color:white;">Details</a>`;
                },
            }],
            initComplete: function() {
                this.api().columns().every(function() {
                    var column = this;
                    switch (column.title()) {
                        case 'Category':
                            column.data().unique().sort().each(function(d, j) {
                                $('.kt-input[data-col-index="3"]').append('<option value="' + d + '">' + d + '</option>');
                            });
                            break;
                    }
                });
            },
            columnDefs: [{
                targets: [0, 1, 2, 3, 4],
                className: 'text-center',
                orderable: false,
            }],
        });
        table.on('order.dt search.dt', function() {
            table.column(0, {
                search: 'applied',
                order: 'applied'
            }).nodes().each(function(cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
        var filter = function() {
            var val = $.fn.dataTable.util.escapeRegex($(this).val());
            table.column($(this).data('col-index')).search(val ? val : '', false, false).draw();
        };
        var asdasd = function(value, index) {
            var val = $.fn.dataTable.util.escapeRegex(value);
            table.column(index).search(val ? val : '', false, true);
        };
        $('#kt_search_content_category').on('change', function(e) {
            e.preventDefault();
            var params = {};
            $('.kt-input').each(function() {
                var i = $(this).data('col-index');
                if (params[i]) {
                    params[i] += '|' + $(this).val();
                } else {
                    params[i] = $(this).val();
                }
            });
            $.each(params, function(i, val) {
                // apply search params to datatable
                table.column(i).search(val ? val : '', false, false);
            });
            table.table().draw();
        });
        $('#kt_search_all').on('keyup', function() {
            table.search(this.value).draw();
        });
    };

    var initTableContentCreator = function() {
        var state_category = "";
        var href_category = "";
        // begin first table
        var table = $('#table_content_creator').DataTable({
            responsive: true,
            // Pagination settings
            dom: `<'row'<'col-sm-12'tr>><'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'lp>>`,
            // read more: https://datatables.net/examples/basic_init/dom.html
            lengthMenu: [5, 10, 25, 50],
            pageLength: 10,
            language: {
                'lengthMenu': 'Display _MENU_',
            },
            searchDelay: 500,
            processing: true,
            serverSide: false,
            ajax: {
                url: '../source/content_creator.json',
                type: 'POST',
                data: {
                    // parameters for custom backend script demo
                    columnsDef: [
                        'no', 'depot', 'vendor', 'pekerjaan', 'sifat',
                        'tanggal', 'status', 'aksi',
                    ],
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                // orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'title',
                title: 'Title',
            }, {
                data: 'category',
                title: 'Category',
                render: function(data, type, row, meta) {
                    state_category = data;
                    var category = {
                        'Daily Tips': {
                            'title': 'Daily Tips',
                            'class': 'btn-label-brand'
                        },
                        'Emergency': {
                            'title': 'Emergency',
                            'class': 'btn-label-warning'
                        },
                        'Article': {
                            'title': 'Article',
                            'class': 'btn-label-dark'
                        },
                    };
                    if (typeof category[data] === 'undefined') {
                        return '<span style="width:100%" class="btn btn-bold btn-sm btn-font-sm btn-label-danger">' + data + '</span>';
                    }
                    return '<span style="width:100%" class="btn btn-bold btn-sm btn-font-sm ' + category[data].class + '">' + category[data].title + '</span>';
                }
            }, {
                data: 'creator',
                title: 'Created By',
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    if (state_category === "Daily Tips") {
                        href_category = "content_edit_dailytips.html";
                    }
                    else if (state_category === "Emergency") {
                        href_category = "content_edit_emergency.html";
                    }
                    else if (state_category === "Article") {
                        href_category = "content_edit_article.html";
                    }
                    else {
                        href_category = "#";
                    }
                    return `<button type="button" class="btn btn-clean btn-icon btn-sm btn-icon-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="flaticon-more"></i>
                    </button>
                    <div style="min-width:9rem;padding:5px;" class="dropdown-menu dropdown-menu-right">
                    <a href="`+ href_category +`" style="margin-bottom:5px;" class="dropdown-item btn btn-secondary"> <i class="fa fa-arrow-right"></i> Edit</button>&nbsp;
                    <a href="#"  class="dropdown-item btn btn-secondary" id="kt_sweetalert_delete">  <i class="fa fa-times"></i> Delete</a>
                    <script>
                        $('#kt_sweetalert_delete').click(function(e) {
                            swal.fire({
                                title: 'Are you sure?',
                                text: "You won't be able to revert this!",
                                type: 'warning',
                                showCancelButton: true,
                                confirmButtonText: 'Yes, delete it!',
                                cancelButtonText: 'No, cancel!',
                                reverseButtons: true
                            }).then(function(result) {
                                if (result.value) {
                                    swal.fire(
                                            'Deleted!',
                                            'Post has been deleted.',
                                            'success'
                                        )
                                }
                            });
                        });
                    </script>`;
                },
            }],
            initComplete: function() {
                this.api().columns().every(function() {
                    var column = this;
                    switch (column.title()) {
                        case 'Category':
                            column.data().unique().sort().each(function(d, j) {
                                $('.kt-input[data-col-index="3"]').append('<option value="' + d + '">' + d + '</option>');
                            });
                            break;
                    }
                });
            },
            columnDefs: [{
                targets: [0, 1, 2, 3, 4],
                className: 'text-center',
                orderable: false,
            }],
        });
        table.on('order.dt search.dt', function() {
            table.column(0, {
                search: 'applied',
                order: 'applied'
            }).nodes().each(function(cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
        var filter = function() {
            var val = $.fn.dataTable.util.escapeRegex($(this).val());
            table.column($(this).data('col-index')).search(val ? val : '', false, false).draw();
        };
        var asdasd = function(value, index) {
            var val = $.fn.dataTable.util.escapeRegex(value);
            table.column(index).search(val ? val : '', false, true);
        };
        $('#kt_search_category').on('change', function(e) {
            e.preventDefault();
            var params = {};
            $('.kt-input').each(function() {
                var i = $(this).data('col-index');
                if (params[i]) {
                    params[i] += '|' + $(this).val();
                } else {
                    params[i] = $(this).val();
                }
            });
            $.each(params, function(i, val) {
                // apply search params to datatable
                table.column(i).search(val ? val : '', false, false);
            });
            table.table().draw();
        });
        $('#kt_search_all').on('keyup', function() {
            table.search(this.value).draw();
        });
    };

    var initTableContentEmbassy = function() {
        var table = $('#table_content_embassy');
        // begin first table
        table.DataTable({
            info: true,
            paging: true,
            lengthChange: true,
            searching: true,
            responsive: true,
            ajax: {
                url: '../source/content_embassy.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                // orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'title',
                title: 'Title',
            }, {
                data: 'creator',
                title: 'Created By',
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
					<button type="button" class="btn btn-clean btn-icon btn-sm btn-icon-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="flaticon-more"></i>
					</button>
					<div style="min-width:9rem;padding:5px;" class="dropdown-menu dropdown-menu-right">
					<a href="content_edit.html" style="margin-bottom:5px;" class="dropdown-item btn btn-secondary"> <i class="fa fa-arrow-right"></i> Edit</button>&nbsp;
					<a href="#"  class="dropdown-item btn btn-secondary" id="kt_sweetalert_delete">  <i class="fa fa-times"></i> Delete</a>
                    <script>
                        $('#kt_sweetalert_delete').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, delete it!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Deleted!',
                                            'Post has been deleted.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }],
            columnDefs: [{
                targets: [0, 1, 2, 3],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableInterest = function() {
        var table = $('#table_interest');
        // begin first table
        table.DataTable({
            info: true,
            paging: true,
            lengthChange: false,
            searching: false,
            responsive: true,
            ajax: {
                url: '../source/interest.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'interest',
                title: 'Interest'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 200,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
                    <a href="#" class="btn btn-sm btn-success" data-toggle="modal" data-target="#kt_modal_edit" style="color:white;">Edit</a>&nbsp;<a href="#" class="btn btn-sm btn-danger" id="kt_sweetalert_delete" style="color:white;">Delete</a>
                    <script>
                        $('#kt_sweetalert_delete').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, delete it!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Deleted!',
                                            'Interest has been deleted.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableGoal = function() {
        var table = $('#table_goal');
        // begin first table
        table.DataTable({
            info: true,
            paging: true,
            lengthChange: false,
            searching: false,
            responsive: true,
            ajax: {
                url: '../source/goal.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'goal',
                title: 'Goal'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 200,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
                    <a href="#" class="btn btn-sm btn-success" data-toggle="modal" data-target="#kt_modal_edit" style="color:white;">Edit</a>&nbsp;<a href="#" class="btn btn-sm btn-danger" id="kt_sweetalert_delete" style="color:white;">Delete</a>
                    <script>
                        $('#kt_sweetalert_delete').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, delete it!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Deleted!',
                                            'Interest has been deleted.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableRank = function() {
        var table = $('#table_rank');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/rank.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'level',
                title: 'Level',
                width: 50
            }, {
                data: 'rank',
                title: 'Rank'
            }, {
                data: 'classification',
                title: 'Classification'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 200,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
                    <a href="#" class="btn btn-sm btn-success" data-toggle="modal" data-target="#kt_modal_edit" style="color:white;">Edit</a>&nbsp;<a href="#" class="btn btn-sm btn-danger" id="kt_sweetalert_delete" style="color:white;">Delete</a>
                    <script>
                        $('#kt_sweetalert_delete').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, delete it!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Deleted!',
                                            'Rank has been deleted.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableTopic = function() {
        var table = $('#table_topic');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/topic.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'topic',
                title: 'Topic'
            }, {
                data: 'img',
                title: 'Icon',
                render: function(data, type, full, meta) {
                    return `
                    <img style="width:30px" src="${data}" alt="image" data-pagespeed-url-hash="2491512603" onload="pagespeed.CriticalImages.checkImageForCriticality(this);">`
                }
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 200,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
                    <a href="#" class="btn btn-sm btn-success" data-toggle="modal" data-target="#kt_modal_topic_edit" style="color:white;">Edit</a>&nbsp;<a href="#" class="btn btn-sm btn-danger" id="kt_sweetalert_delete" style="color:white;">Delete</a>
                    <script>
                        $('#kt_sweetalert_delete').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, delete it!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Deleted!',
                                            'Topic has been deleted.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableCreator = function() {
        var table = $('#table_creator');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/creator.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                // orderable: false,
            }, {
                data: 'creator',
                title: 'Content Creator'
            }, {
                data: 'username',
                title: 'Username'
            }, {
                data: 'type',
                title: 'Content Type',
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 200,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
                    <a href="#" class="btn btn-sm btn-success" style="color:white;" data-toggle="modal" data-target="#kt_modal_creator_edit">Edit</a>&nbsp;<a href="#" class="btn btn-sm btn-danger" id="kt_sweetalert_blacklist" style="color:white;">Blacklist</a>
                    <script>
                        $('#kt_sweetalert_blacklist').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, add to blacklist!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Blacklisted!',
                                            'User content creator has been added to blacklist.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableCreatorBlacklist = function() {
        var table = $('#table_creator_blacklist');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/creator.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                // orderable: false,
            }, {
                data: 'creator',
                title: 'Content Creator'
            }, {
                data: 'username',
                title: 'Username'
            }, {
                data: 'type',
                title: 'Content Type',
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableEmbassy = function() {
        var table = $('#table_embassy');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/embassy.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'embassy',
                title: 'Embassy'
            }, {
                data: 'country',
                title: 'Country'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 200,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
                    <a href="#" class="btn btn-sm btn-success" style="color:white;" data-toggle="modal" data-target="#kt_modal_embassy_edit">Edit</a>&nbsp;<a href="#" class="btn btn-sm btn-danger" id="kt_sweetalert_blacklist" style="color:white;">Blacklist</a>
                    <script>
                        $('#kt_sweetalert_blacklist').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, add to blacklist!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Blacklisted!',
                                            'User embassy has been added to blacklist.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableEmbassyBlacklist = function() {
        var table = $('#table_embassy_blacklist');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/embassy.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'embassy',
                title: 'Embassy'
            }, {
                data: 'country',
                title: 'Country'
            }, ],
            columnDefs: [{
                targets: [0, 1, 2],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableUser = function() {
        var table = $('#table_user');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/user.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'name',
                title: 'Name'
            }, {
                data: 'username',
                title: 'Username'
            }, {
                data: 'badge',
                title: 'Badge'
            }, {
                data: 'report',
                title: 'Reports'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 200,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
                    <a href="user_userdetail.html" class="btn btn-sm btn-brand" style="color:white;">Details</a>&nbsp;<a href="#" class="btn btn-sm btn-danger" id="kt_sweetalert_blacklist" style="color:white;">Blacklist</a>
                    <script>
                        $('#kt_sweetalert_blacklist').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, add to blacklist!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Blacklisted!',
                                            'User has been added to blacklist.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3, 4],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableUserBlacklist = function() {
        var table = $('#table_user_blacklist');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/user.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'name',
                title: 'Name'
            }, {
                data: 'username',
                title: 'Username'
            }, {
                data: 'badge',
                title: 'Badge'
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableQuestionAll = function() {
        var table = $('#table_question_all');
        // begin first table
        table.DataTable({
            info: true,
            paging: true,
            lengthChange: true,
            searching: true,
            responsive: true,
            ajax: {
                url: '../source/question.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'question',
                title: 'Question'
            }, {
                data: 'answer',
                title: 'Answers'
            }, {
                data: 'status',
                title: 'Status',
                render: function(data, type, row, meta) {
                    var status = {
                        open: {
                            'title': 'Open',
                            'class': 'btn-label-success'
                        },
                        solved: {
                            'title': 'Solved',
                            'class': 'btn-label-brand'
                        },
                    };
                    if (typeof status[data] === 'undefined') {
                        return data;
                    }
                    return '<span style="width:100%" class="btn btn-bold btn-sm btn-font-sm ' + status[data].class + '">' + status[data].title + '</span>';
                }
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
					<button type="button" class="btn btn-clean btn-icon btn-sm btn-icon-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="flaticon-more"></i>
					</button>
					<div style="min-width:9rem;padding:5px;" class="dropdown-menu dropdown-menu-right">
					<a href="question_detail.html" style="margin-bottom:5px;" class="dropdown-item btn btn-secondary"> <i class="fa fa-arrow-right"></i> Details</button>&nbsp;
					<a href="#"  class="dropdown-item btn btn-secondary" id="kt_sweetalert_blacklist">  <i class="fa fa-times"></i> Blacklist</a>
                    <script>
                        $('#kt_sweetalert_blacklist').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, add to blacklist!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Blacklisted!',
                                            'Question has been added to blacklist.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3, 4],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableQuestionBlacklist = function() {
        var table = $('#table_question_blacklist');
        // begin first table
        table.DataTable({
            info: true,
            paging: true,
            lengthChange: true,
            searching: true,
            responsive: true,
            ajax: {
                url: '../source/question.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'question',
                title: 'Question'
            }, {
                data: 'answer',
                title: 'Answers'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 100,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `<a href="question_detail.html" class="btn btn-sm btn-brand" style="color:white;">Details</a>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableQuestionReported = function() {
        var table = $('#table_question_reported');
        // begin first table
        table.DataTable({
            info: true,
            paging: true,
            lengthChange: true,
            searching: true,
            responsive: true,
            ajax: {
                url: '../source/question.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'question',
                title: 'Question'
            }, {
                data: 'answer',
                title: 'Answers'
            }, {
                data: 'report',
                title: 'Reports'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
					<button type="button" class="btn btn-clean btn-icon btn-sm btn-icon-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="flaticon-more"></i>
					</button>
					<div style="min-width:9rem;padding:5px;" class="dropdown-menu dropdown-menu-right">
					<a href="question_detail.html" style="margin-bottom:5px;" class="dropdown-item btn btn-secondary"> <i class="fa fa-arrow-right"></i> Details</button>&nbsp;
					<a href="#"  class="dropdown-item btn btn-secondary" id="kt_sweetalert_blacklist">  <i class="fa fa-times"></i> Blacklist</a>
                    <script>
                        $('#kt_sweetalert_blacklist').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, add to blacklist!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Blacklisted!',
                                            'Question has been added to blacklist.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3, 4],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTablePost = function() {
        var table = $('#table_post');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/post.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'post',
                title: 'Post'
            }, {
                data: 'user',
                title: 'User'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
                    <button type="button" class="btn btn-clean btn-icon btn-sm btn-icon-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="flaticon-more"></i>
					</button>
					<div style="min-width:9rem;padding:5px;" class="dropdown-menu dropdown-menu-right">
					<a href="post_detail.html" style="margin-bottom:5px;" class="dropdown-item btn btn-secondary"> <i class="fa fa-arrow-right"></i> Details</button>&nbsp;
					<a href="#"  class="dropdown-item btn btn-secondary" id="kt_sweetalert_blacklist">  <i class="fa fa-times"></i> Blacklist</a>
                    <script>
                        $('#kt_sweetalert_blacklist').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, add to blacklist!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Blacklisted!',
                                            'Post has been added to blacklist.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTablePostReported = function() {
        var table = $('#table_post_reported');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/post.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'post',
                title: 'Post'
            }, {
                data: 'user',
                title: 'User'
            }, {
                data: 'report',
                title: 'Report'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
                    <button type="button" class="btn btn-clean btn-icon btn-sm btn-icon-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="flaticon-more"></i>
					</button>
					<div style="min-width:9rem;padding:5px;" class="dropdown-menu dropdown-menu-right">
					<a href="post_detail.html" style="margin-bottom:5px;" class="dropdown-item btn btn-secondary"> <i class="fa fa-arrow-right"></i> Details</button>&nbsp;
					<a href="#"  class="dropdown-item btn btn-secondary" id="kt_sweetalert_blacklist">  <i class="fa fa-times"></i> Blacklist</a>
                    <script>
                        $('#kt_sweetalert_blacklist').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, add to blacklist!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Blacklisted!',
                                            'Post has been added to blacklist.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3, 4],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTablePostBlacklist = function() {
        var table = $('#table_post_blacklist');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/post.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'post',
                title: 'Post'
            }, {
                data: 'user',
                title: 'User'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `<a href="post_detail.html" class="btn btn-sm btn-brand" style="color:white;">Details</a>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableAnswer = function() {
        var table = $('#table_answer');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/answer.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'answer',
                title: 'Answer'
            }, {
                data: 'status',
                title: 'Status'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
                    <button type="button" class="btn btn-clean btn-icon btn-sm btn-icon-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="flaticon-more"></i>
					</button>
					<div style="min-width:9rem;padding:5px;" class="dropdown-menu dropdown-menu-right">
					<a href="answer_detail.html" style="margin-bottom:5px;" class="dropdown-item btn btn-secondary"> <i class="fa fa-arrow-right"></i> Details</button>&nbsp;
					<a href="#"  class="dropdown-item btn btn-secondary" id="kt_sweetalert_blacklist">  <i class="fa fa-times"></i> Blacklist</a>
                    <script>
                        $('#kt_sweetalert_blacklist').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, add to blacklist!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Blacklisted!',
                                            'Answer has been added to blacklist.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableAnswerReported = function() {
        var table = $('#table_answer_reported');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/answer.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'answer',
                title: 'Answer'
            }, {
                data: 'status',
                title: 'Status'
            }, {
                data: 'report',
                title: 'Report'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `
                    <button type="button" class="btn btn-clean btn-icon btn-sm btn-icon-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="flaticon-more"></i>
					</button>
					<div style="min-width:9rem;padding:5px;" class="dropdown-menu dropdown-menu-right">
					<a href="answer_detail.html" style="margin-bottom:5px;" class="dropdown-item btn btn-secondary"> <i class="fa fa-arrow-right"></i> Details</button>&nbsp;
					<a href="#"  class="dropdown-item btn btn-secondary" id="kt_sweetalert_blacklist">  <i class="fa fa-times"></i> Blacklist</a>
                    <script>
                        $('#kt_sweetalert_blacklist').click(function(e) {
            	            swal.fire({
            	                title: 'Are you sure?',
            	                text: "You won't be able to revert this!",
            	                type: 'warning',
            	                showCancelButton: true,
            	                confirmButtonText: 'Yes, add to blacklist!',
            	                cancelButtonText: 'No, cancel!',
            	                reverseButtons: true
            	            }).then(function(result) {
            	                if (result.value) {
                                    swal.fire(
                                            'Blacklisted!',
                                            'Answer has been added to blacklist.',
                                            'success'
                                        )
            	                }
            	            });
            	        });
                    </script>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3, 4],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    var initTableAnswerBlacklist = function() {
        var table = $('#table_answer_blacklist');
        // begin first table
        table.DataTable({
            responsive: true,
            ajax: {
                url: '../source/answer.json',
                type: 'POST',
                data: {
                    pagination: {
                        perpage: 50,
                    },
                },
            },
            columns: [{
                data: 'null',
                title: 'No',
                width: 25,
                render: function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                // title: 'No.',
                orderable: false,
            }, {
                data: 'date',
                title: 'Date',
                width: 150
            }, {
                data: 'answer',
                title: 'Answer'
            }, {
                data: 'status',
                title: 'Status'
            }, {
                field: 'action',
                title: 'Action',
                responsivePriority: -1,
                className: 'text-center',
                width: 50,
                orderable: false,
                render: function(data, type, full, meta) {
                    return `<a href="answer_detail.html" class="btn btn-sm btn-brand" style="color:white;">Details</a>`;
                },
            }, ],
            columnDefs: [{
                targets: [0, 1, 2, 3],
                className: 'text-center',
                orderable: true,
            }],
        });
    };

    return {
        //main function to initiate the module
        init: function() {
            initTableInterest();
            initTableGoal();
            initTableRank();
            initTableTopic();
            initTableCreator();
            initTableCreatorBlacklist();
            initTableEmbassy();
            initTableEmbassyBlacklist();
            initTableUser();
            initTableUserBlacklist();
            initTableQuestionAll();
            initTableQuestionReported();
            initTableQuestionBlacklist();
            initTableContent();
            initTableContentReported();
            initTableContentBlacklist();
            initTableContentEmbassy();
            initTableContentCreator();
            initTablePost();
            initTablePostReported();
            initTablePostBlacklist();
            initTableAnswer();
            initTableAnswerReported();
            initTableAnswerBlacklist();
        },
    };

}();
// end: Admin Page

jQuery(document).ready(function() {
    KTDatatablesSearchOptionsAdvancedSearch.init();
});
