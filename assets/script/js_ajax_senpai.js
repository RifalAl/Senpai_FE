"use strict";
var KTDatatablesSearchOptionsAdvancedSearch = function() {

	$.fn.dataTable.Api.register('column().title()', function() {
		return $(this.header()).text().trim();
	});
	var initTable1 = function() {
		var table = $('#tbl_input_data_pekerja_baru');

		// begin first table
		table.DataTable({
			responsive: true,
			searchDelay: 500,
			processing: true,
			serverSide: false,
			ajax: {
				url: '../source/input_data_pekerja_baru.json',
				type: 'POST',
				data: {
					pagination: {
						perpage: 50,
					},
				},
			},
			columns: [
			{
				data: 'no',
				title: 'No.',
				orderable: false,
			},{
				data: 'nama_pekerja',
				title: 'Nama Pekerja',
			},{
				data: 'kategori',
				title: 'Kategori',
			},{
				data: 'perusahaan',
				title: 'Perusahaan',
			},{
				field: 'aksi',
				title: 'Aksi',
				responsivePriority: -1,
				className: 'text-center',
				orderable: false,
				width: 100,
				render: function(data, type, full, meta) {
					return `
					<button type="button" class="btn btn-hover-brand btn-elevate-hover btn-icon btn-sm btn-icon-md btn-circle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="flaticon-more-1"></i>
					</button>
					<div style="min-width:9rem;padding:5px;" class="dropdown-menu dropdown-menu-right">
					<a href="rincian_data_pekerja.html" style="margin-bottom:5px;" class="dropdown-item btn btn-secondary" href="#"> <i class="fa fa-clipboard-list"></i>Rincian</a>
					<button data-toggle="modal" data-target="#terima" style="margin-bottom:5px;" class="dropdown-item btn btn-secondary" href="#"> <i class="fa fa-check"></i>Terima</button>
					<button data-toggle="modal" data-target="#tolak"  class="dropdown-item btn btn-secondary"> <i class="fa fa-times"></i>Tolak</button>`
					;
					/*return `
					<a href="rincian_data_pekerja.html" class="btn btn-sm btn-primary" style="color:white;border-radius:20px">Rincian</a> &nbsp;` +
					'<a data-toggle="modal" data-target="#terima" class="btn btn-sm btn-success" style="color:white;border-radius:20px">Terima</a> &nbsp;' +
					'<a data-toggle="modal" data-target="#tolak" class="btn btn-sm btn-danger" style="color:white;border-radius:20px">Tolak</a>';*/
				},
			}],
			columnDefs: [
			{
				targets: [0,1,2,3,4],
				className: 'text-center'
			}
			],
		});
	};
	return {
		//main function to initiate the module
		init: function() {
			initTable1();

		},

	};

}();

jQuery(document).ready(function() {
	KTDatatablesSearchOptionsAdvancedSearch.init();
});
