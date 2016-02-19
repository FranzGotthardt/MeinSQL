
    create table accept_terms (
        id bigint not null auto_increment,
        authenticator_id varchar(255) not null,
        is_accepted bit not null,
        principal varchar(255) not null,
        version bigint,
        primary key (id),
        unique (principal, authenticator_id)
    ) ENGINE=InnoDB;

    create table access_token (
        id bigint not null auto_increment,
        access_token varchar(255) not null,
        time_to_live_after_use bigint not null,
        user__id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table application (
        id bigint not null auto_increment,
        app_meta_data longtext not null,
        app_wizard_state longtext not null,
        dap_file__id bigint not null,
        primary key (id),
        unique (dap_file__id)
    ) ENGINE=InnoDB;

    create table artifact (
        id bigint not null auto_increment,
        deletion_date datetime,
        relative_path varchar(255),
        dap_file__id bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table artifact_sheets (
        owning_sheet bigint not null,
        artifact_sheet bigint not null,
        artifact_name varchar(255) not null,
        primary key (owning_sheet, artifact_name),
        unique (artifact_sheet)
    ) ENGINE=InnoDB;

    create table authenticable_group (
        id bigint not null auto_increment,
        authenticator_id varchar(255) not null,
        creation_date datetime not null,
        name varchar(255) not null,
        version bigint,
        primary key (id),
        unique (name, authenticator_id)
    ) ENGINE=InnoDB;

    create table custom_data_sink (
        id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table custom_role (
        id bigint not null auto_increment,
        name varchar(255) unique,
        version bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table customrole_auth_group (
        role_id bigint not null,
        auth_group_id bigint not null
    ) ENGINE=InnoDB;

    create table customrole_user (
        user_id bigint not null,
        role_id bigint not null,
        primary key (user_id, role_id)
    ) ENGINE=InnoDB;

    create table daily_export_job_statistics (
        id bigint not null auto_increment,
        configuration_id bigint not null,
        day date not null,
        jobs_executed bigint not null,
        mr_jobs_executed bigint not null,
        compressed_bytes_processed bigint not null,
        primary key (id),
        unique (configuration_id, day)
    ) ENGINE=InnoDB;

    create table daily_import_job_statistics (
        id bigint not null auto_increment,
        configuration_id bigint not null,
        day date not null,
        jobs_executed bigint not null,
        mr_jobs_executed bigint not null,
        compressed_bytes_imported bigint not null,
        primary key (id),
        unique (configuration_id, day)
    ) ENGINE=InnoDB;

    create table daily_workbook_statistics (
        id bigint not null auto_increment,
        configuration_id bigint not null,
        day date not null,
        jobs_executed bigint not null,
        mr_jobs_executed bigint not null,
        compressed_bytes_processed bigint not null,
        compressed_bytes_written bigint not null,
        computed_preview_sheets bigint not null,
        sheets_processed bigint not null,
        primary key (id),
        unique (configuration_id, day)
    ) ENGINE=InnoDB;

    create table dap_file (
        id bigint not null auto_increment,
        bytes_processed bigint,
        creation_date datetime not null,
        description varchar(255),
        extension varchar(255) not null,
        file_mode varchar(255) not null,
        job_status varchar(255) not null,
        last_changed_date datetime not null,
        last_executed datetime,
        name varchar(255) not null,
        uuid varchar(255) not null,
        version bigint,
        folder_fk bigint not null,
        permission_fk bigint not null,
        primary key (id),
        unique (uuid),
        unique (name, extension, folder_fk)
    ) ENGINE=InnoDB;

    create table dap_job_configuration (
        id bigint not null auto_increment,
        data_volume_size_by_license_period bigint not null,
        expire_time_days integer,
        hadoop_properties longtext,
        logging_properties longtext,
        min_keep_count integer,
        pull_type integer not null,
        root_logger_level varchar(255),
        schedule varchar(255),
        dap_file__id bigint not null,
        primary key (id),
        unique (dap_file__id)
    ) ENGINE=InnoDB;

    create table dap_job_execution (
        id bigint not null auto_increment,
        user varchar(255),
        hadoop_properties longtext,
        job_data longtext,
        job_exception longtext,
        job_status integer not null,
        logging_properties longtext,
        queued_time datetime,
        root_logger_level varchar(255),
        start_time datetime,
        stop_time datetime,
        triggered_by integer,
        type varchar(255) not null,
        created_data__id bigint,
        dap_job_configuration__id bigint not null,
        execution_plan_fk bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table dap_job_execution_dap_job_counter (
        dap_job_execution__id bigint not null,
        value bigint not null,
        counter integer not null,
        primary key (dap_job_execution__id, counter)
    ) ENGINE=InnoDB;

    create table data (
        id bigint not null auto_increment,
        being_compacted bit not null,
        datameer_version varchar(255),
        deletion_date datetime,
        effective_date datetime not null,
        size_archived bit not null,
        status integer not null,
        uri varchar(255) not null,
        dap_file__id bigint not null,
        dap_job_configuration__id bigint,
        partition_index__id bigint,
        primary key (id),
        unique (dap_file__id)
    ) ENGINE=InnoDB;

    create table data_base_data_sink (
        id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table data_migration (
        id bigint not null auto_increment,
        data__id bigint not null,
        migration_job__id bigint,
        primary key (id),
        unique (data__id)
    ) ENGINE=InnoDB;

    create table data_mining_configuration (
        id bigint not null auto_increment,
        primary key (id)
    ) ENGINE=InnoDB;

    create table data_mining_configuration_property (
        id bigint not null auto_increment,
        position integer not null,
        property_key varchar(255) not null,
        property_value longtext,
        secure bit not null,
        configuration_fk bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table data_mining_model (
        id bigint not null auto_increment,
        sheet_id varchar(255) not null,
        sheet_name varchar(255) not null,
        workbook_data_fk bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table data_mining_model_property (
        id bigint not null auto_increment,
        position integer not null,
        property_key varchar(255) not null,
        property_value longtext,
        secure bit not null,
        configuration_fk bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table data_partition (
        id bigint not null auto_increment,
        data_statistic__bytes bigint not null,
        data_statistic__failed_record_count bigint not null,
        data_statistic__output_partition_count bigint not null,
        data_statistic__record_count bigint not null,
        data_statistic__uncompressed_bytes bigint not null,
        entry_type integer not null,
        index_key bigint,
        relative_path varchar(255),
        partition_index__id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table data_sink_configuration (
        error_handling_mode integer not null,
        notification_addresses varchar(255),
        notification_success_addresses varchar(255),
        partition_selector longtext,
        id bigint not null,
        connection_fk bigint not null,
        sheet_fk bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table data_source_configuration (
        data_version integer not null,
        error_handling_mode integer not null,
        last_changed datetime,
        max_log_errors integer,
        max_mappers integer,
        max_preview_records integer not null,
        notification_addresses varchar(255),
        notification_success_addresses varchar(255),
        partition_definition longtext,
        id bigint not null,
        connection_fk bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table data_source_data (
        data_statistic__bytes bigint not null,
        data_statistic__failed_record_count bigint not null,
        data_statistic__output_partition_count bigint not null,
        data_statistic__record_count bigint not null,
        data_statistic__uncompressed_bytes bigint not null,
        max_split_value varchar(512),
        relative_sheet_path varchar(255) not null,
        sheet_schema_json longtext,
        sheet_schema_fk bigint,
        id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table data_store (
        type varchar(20) not null,
        id bigint not null auto_increment,
        type_id varchar(255) not null,
        dap_file__id bigint not null,
        db_type_fk bigint,
        primary key (id),
        unique (dap_file__id)
    ) ENGINE=InnoDB;

    create table data_store_configuration_property (
        id bigint not null auto_increment,
        position integer not null,
        property_key varchar(255) not null,
        property_value longtext,
        secure bit not null,
        configuration_fk bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table data_volume_summary (
        id bigint not null auto_increment,
        day datetime not null,
        job_conf_id bigint not null,
        volume bigint not null,
        primary key (id),
        unique (day, job_conf_id)
    ) ENGINE=InnoDB;

    create table db_driver (
        id bigint not null auto_increment,
        name varchar(255) unique,
        connection_pattern varchar(255),
        dialect_class_name varchar(255),
        driver_class_name varchar(255),
        uuid varchar(255) not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table db_driver_jar_file_names (
        db_driver__id bigint not null,
        jar_file_names_element varchar(255)
    ) ENGINE=InnoDB;

    create table deprecated_column_style (
        id bigint not null auto_increment,
        alignment integer,
        background_color varchar(255),
        color varchar(255),
        column_id varchar(255) not null,
        date_pattern varchar(255),
        decimal_digits integer,
        name varchar(255),
        thousand_separator bit not null,
        width integer not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table deprecated_field_definition_entity (
        id bigint not null auto_increment,
        column_id varchar(255) not null,
        field_type longtext,
        name varchar(255),
        workbook_sheet_data_fk bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table deprecated_sheet_column_style (
        sheet__id bigint not null,
        column_styles__id bigint not null,
        primary key (column_styles__id)
    ) ENGINE=InnoDB;

    create table deprecated_sheet_schema (
        id bigint not null auto_increment,
        primary key (id)
    ) ENGINE=InnoDB;

    create table deprecated_sheet_schema_column_style (
        sheet_schema__id bigint not null,
        column_styles__id bigint not null,
        primary key (column_styles__id)
    ) ENGINE=InnoDB;

    create table deprecated_sheet_schema_sort_keys (
        schema_id bigint not null,
        sort_keys__id bigint not null,
        unique (sort_keys__id)
    ) ENGINE=InnoDB;

    create table deprecated_sort_key (
        id bigint not null auto_increment,
        column_name varchar(255),
        sort_order integer,
        primary key (id)
    ) ENGINE=InnoDB;

    create table deprecated_sort_sort_keys (
        sort__id bigint not null,
        sort_keys__id bigint not null,
        unique (sort_keys__id)
    ) ENGINE=InnoDB;

    create table execution_dependencies (
        depends_on_execution_id bigint not null,
        execution_id bigint not null
    ) ENGINE=InnoDB;

    create table execution_plan (
        id bigint not null auto_increment,
        primary key (id)
    ) ENGINE=InnoDB;

    create table extension_point_state (
        id bigint not null auto_increment,
        enabled bit not null,
        extension_point_id varchar(255) not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table extension_state (
        id bigint not null auto_increment,
        enabled bit not null,
        extension_id varchar(255) not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table field (
        id bigint not null auto_increment,
        accept_empty_entries bit,
        include bit not null,
        name varchar(255),
        origin varchar(255),
        pattern varchar(255),
        position integer not null,
        type longtext not null,
        datasource_id bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table file_data_sink (
        character_encoding varchar(255) not null,
        clear_target_directory bit not null,
        confirm_overwrite bit not null,
        consecutive_numbering integer,
        delimiter_string varchar(255) not null,
        escape_string varchar(255),
        export_file_type varchar(255) not null,
        file_name varchar(255) not null,
        include_header bit not null,
        max_file_size integer,
        quote_string varchar(255),
        id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table file_dependency (
        id bigint not null auto_increment,
        key_text longtext,
        path varchar(255),
        dependency_file_id bigint,
        source_file_id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table filter (
        id bigint not null auto_increment,
        connector integer,
        source_sheet__id bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table filter_argument (
        id bigint not null auto_increment,
        column_name varchar(255),
        filter_expression varchar(255),
        type varchar(255),
        value longtext,
        value_static bit not null,
        filter_fk bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table folder (
        id bigint not null auto_increment,
        hidden bit not null,
        name varchar(255) not null,
        parent_folder_fk bigint,
        permission_fk bigint not null,
        primary key (id),
        unique (permission_fk),
        unique (name, parent_folder_fk)
    ) ENGINE=InnoDB;

    create table folder_group_permission (
        id bigint not null auto_increment,
        flags__readable bit not null,
        flags__writeable bit not null,
        group_name varchar(255) not null,
        permission_id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table folder_permission (
        id bigint not null auto_increment,
        other_permission_flags__readable bit not null,
        other_permission_flags__writeable bit not null,
        owner varchar(255) not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table formula (
        id bigint not null auto_increment,
        column_id varchar(255) not null,
        column_index integer not null,
        formula_string longtext,
        sheet_fk bigint not null,
        primary key (id),
        unique (sheet_fk, column_index)
    ) ENGINE=InnoDB;

    create table group_permission (
        id bigint not null auto_increment,
        group_name varchar(255) not null,
        permission_bits varchar(255),
        permission__id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table infographic_model (
        id bigint not null auto_increment,
        model longtext,
        dap_file__id bigint not null,
        primary key (id),
        unique (dap_file__id)
    ) ENGINE=InnoDB;

    create table installation_history (
        id bigint not null auto_increment,
        install_date datetime not null,
        version varchar(255) not null unique,
        primary key (id)
    ) ENGINE=InnoDB;

    create table job_configuration_property (
        id bigint not null auto_increment,
        position integer not null,
        property_key varchar(255) not null,
        property_value longtext,
        secure bit not null,
        configuration_fk bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table mapping (
        id bigint not null auto_increment,
        name varchar(255),
        nullable bit not null,
        pattern varchar(255),
        src_column_index integer,
        datasink_id bigint not null,
        primary key (id),
        unique (datasink_id, src_column_index)
    ) ENGINE=InnoDB;

    create table optional_upgrade (
        id bigint not null auto_increment,
        upgrade_id varchar(255) not null unique,
        primary key (id)
    ) ENGINE=InnoDB;

    create table partition_index (
        id bigint not null auto_increment,
        key_type longtext,
        primary key (id)
    ) ENGINE=InnoDB;

    create table permission (
        id bigint not null auto_increment,
        other_permission_bits varchar(255),
        owner varchar(255) not null,
        shared bit not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table plugin_state (
        id bigint not null auto_increment,
        enabled bit not null,
        plugin_id varchar(255) not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table property (
        id bigint not null auto_increment,
        name varchar(255) unique,
        value varchar(21000) not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table role_capability (
        role_id bigint not null,
        capability varchar(255) not null,
        primary key (role_id, capability)
    ) ENGINE=InnoDB;

    create table sheet (
        id bigint not null auto_increment,
        is_artifact_sheet bit not null,
        keep bit not null,
        last_changed_date datetime not null,
        name varchar(255),
        next_column_id integer not null,
        partition_definition longtext,
        partition_selector longtext,
        position integer not null,
        run_triggering_configuration__run_trigger bit,
        run_triggering_configuration__triggering_condition varchar(255),
        sheet_definition longtext,
        sheet_id varchar(255) not null,
        meta_data_json longtext,
        sheet_type varchar(255) not null,
        data_mining_sheet_configuration_fk bigint,
        data_source_id bigint,
        external_sheet__id bigint,
        filter_fk bigint,
        sheet_view_fk bigint not null,
        sort_fk bigint,
        workbook_fk bigint,
        primary key (id),
        unique (workbook_fk, name)
    ) ENGINE=InnoDB;

    create table sheet_field (
        sheet__id bigint not null,
        field_entities__id bigint not null,
        unique (field_entities__id)
    ) ENGINE=InnoDB;

    create table sheet_snapshot (
        id bigint not null auto_increment,
        max_split_value varchar(255),
        relative_path varchar(255) not null,
        sheet_id varchar(255) not null,
        sheet_schema_json longtext,
        statistics longtext,
        data__id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table sheet_snapshot_sheet_snapshot (
        sheet_snapshot__id bigint not null,
        referenced_inputs__id bigint not null,
        primary key (sheet_snapshot__id, referenced_inputs__id)
    ) ENGINE=InnoDB;

    create table sheet_viewstate (
        id bigint not null auto_increment,
        current_start bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table sink_data (
        relative_sheet_path varchar(255) not null,
        id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table sort (
        id bigint not null auto_increment,
        sort_keys_json longtext not null,
        topn integer,
        source_sheet__id bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table stored_file (
        id bigint not null auto_increment,
        dap_file__id bigint not null,
        primary key (id),
        unique (dap_file__id)
    ) ENGINE=InnoDB;

    create table system_job_configuration (
        data_generator bit not null,
        id bigint not null,
        full_data_permission_fk bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table system_job_data (
        id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table temporary_data (
        id bigint not null auto_increment,
        data longtext,
        dap_file__id bigint not null,
        primary key (id),
        unique (dap_file__id)
    ) ENGINE=InnoDB;

    create table test_entity (
        id bigint not null auto_increment,
        foo varchar(255),
        dap_file__id bigint not null,
        primary key (id),
        unique (dap_file__id)
    ) ENGINE=InnoDB;

    create table test_entity2 (
        id bigint not null auto_increment,
        json_model longtext,
        not_nullable_value_type longtext not null,
        nullable_value_type longtext,
        simple_type longtext,
        version bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table test_properties (
        id bigint not null auto_increment,
        value varchar(255),
        entity_fk bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table user (
        id bigint not null auto_increment,
        name varchar(255) unique,
        additional_information varchar(4096) not null,
        creation_date datetime not null,
        email varchar(255) not null,
        enabled bit not null,
        expiration_date datetime,
        ext_authenticator_id varchar(255) not null,
        login_count bigint default 0 not null,
        login_date datetime,
        password varchar(255),
        version bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table user_group (
        id bigint not null auto_increment,
        name varchar(255) unique,
        creation_date datetime not null,
        version bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table usergroup_user (
        user_id bigint not null,
        group_id bigint not null
    ) ENGINE=InnoDB;

    create table workbook_configuration (
        advanced_scheduling_in_use bit not null,
        error_handling_mode integer not null,
        max_log_errors integer,
        notification_addresses varchar(255),
        notification_success_addresses varchar(255),
        id bigint not null,
        full_data_permission_fk bigint not null,
        workbook_view_fk bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table workbook_data (
        id bigint not null,
        primary key (id)
    ) ENGINE=InnoDB;

    create table workbook_sheet_data (
        id bigint not null auto_increment,
        data_statistic__bytes bigint not null,
        data_statistic__failed_record_count bigint not null,
        data_statistic__output_partition_count bigint not null,
        data_statistic__record_count bigint not null,
        data_statistic__uncompressed_bytes bigint not null,
        is_artifact_sheet bit not null,
        kept bit not null,
        sheet_id varchar(255) not null,
        sheet_name varchar(255) not null,
        sheet_schema_json longtext,
        sheet_schema_fk bigint,
        partition_index__id bigint,
        workbook_data_fk bigint,
        primary key (id)
    ) ENGINE=InnoDB;

    create table workbook_sheet_edit_data (
        workbook_sheet_data_id bigint not null,
        primary key (workbook_sheet_data_id)
    ) ENGINE=InnoDB;

    create table workbook_sheet_external_data (
        selected_partitions longtext,
        workbook_sheet_data_id bigint not null,
        referenced_workbook_sheet_data_id bigint,
        primary key (workbook_sheet_data_id),
        unique (workbook_sheet_data_id, referenced_workbook_sheet_data_id)
    ) ENGINE=InnoDB;

    create table workbook_sheet_import_data (
        selected_partitions longtext,
        workbook_sheet_data_id bigint not null,
        primary key (workbook_sheet_data_id)
    ) ENGINE=InnoDB;

    create table workbook_sheet_import_data_data_source_data (
        workbook_sheet_import_data_workbook_sheet_data_id bigint not null,
        data_source_datas_id bigint not null
    ) ENGINE=InnoDB;

    create table workbook_viewstate (
        id bigint not null auto_increment,
        current_sheet_index integer,
        primary key (id)
    ) ENGINE=InnoDB;

    alter table access_token 
        add index FK8C6E375EA8B43EB3 (user__id), 
        add constraint FK8C6E375EA8B43EB3 
        foreign key (user__id) 
        references user (id);

    alter table application 
        add index FK5CA405508B7CD475 (dap_file__id), 
        add constraint FK5CA405508B7CD475 
        foreign key (dap_file__id) 
        references dap_file (id);

    alter table artifact 
        add index FKB6C205D28B7CD475 (dap_file__id), 
        add constraint FKB6C205D28B7CD475 
        foreign key (dap_file__id) 
        references dap_file (id);

    alter table artifact_sheets 
        add index FK932B7601CC660E6F (artifact_sheet), 
        add constraint FK932B7601CC660E6F 
        foreign key (artifact_sheet) 
        references sheet (id);

    alter table artifact_sheets 
        add index FK932B7601A783BB9 (owning_sheet), 
        add constraint FK932B7601A783BB9 
        foreign key (owning_sheet) 
        references sheet (id);

    alter table custom_data_sink 
        add index FK23AF8EBAF207CAD2 (id), 
        add constraint FK23AF8EBAF207CAD2 
        foreign key (id) 
        references data_sink_configuration (id);

    alter table customrole_auth_group 
        add index FK9D486D00D9D46FBF (auth_group_id), 
        add constraint FK9D486D00D9D46FBF 
        foreign key (auth_group_id) 
        references authenticable_group (id);

    alter table customrole_auth_group 
        add index FK9D486D0080C36F6D (role_id), 
        add constraint FK9D486D0080C36F6D 
        foreign key (role_id) 
        references custom_role (id);

    alter table customrole_user 
        add index FK4208C1A380C36F6D (role_id), 
        add constraint FK4208C1A380C36F6D 
        foreign key (role_id) 
        references custom_role (id);

    alter table customrole_user 
        add index FK4208C1A3AFCC7D7C (user_id), 
        add constraint FK4208C1A3AFCC7D7C 
        foreign key (user_id) 
        references user (id);

    create index index_dap_file_file_mode on dap_file (file_mode);

    alter table dap_file 
        add index FK63BB6EA8678EC701 (permission_fk), 
        add constraint FK63BB6EA8678EC701 
        foreign key (permission_fk) 
        references permission (id);

    alter table dap_file 
        add index FK63BB6EA8A821CE1C (folder_fk), 
        add constraint FK63BB6EA8A821CE1C 
        foreign key (folder_fk) 
        references folder (id);

    alter table dap_job_configuration 
        add index FK7BD4E2488B7CD475 (dap_file__id), 
        add constraint FK7BD4E2488B7CD475 
        foreign key (dap_file__id) 
        references dap_file (id);

    alter table dap_job_execution 
        add index FK99F9F16A1A68FAD0 (dap_job_configuration__id), 
        add constraint FK99F9F16A1A68FAD0 
        foreign key (dap_job_configuration__id) 
        references dap_job_configuration (id);

    alter table dap_job_execution 
        add index FK99F9F16AD9EFEA8 (created_data__id), 
        add constraint FK99F9F16AD9EFEA8 
        foreign key (created_data__id) 
        references data (id);

    alter table dap_job_execution 
        add index FK99F9F16A8F445433 (execution_plan_fk), 
        add constraint FK99F9F16A8F445433 
        foreign key (execution_plan_fk) 
        references execution_plan (id);

    alter table dap_job_execution_dap_job_counter 
        add index FK8AD0DBF947D70751 (dap_job_execution__id), 
        add constraint FK8AD0DBF947D70751 
        foreign key (dap_job_execution__id) 
        references dap_job_execution (id);

    alter table data 
        add index FK2EEFAA4CF3E322 (partition_index__id), 
        add constraint FK2EEFAA4CF3E322 
        foreign key (partition_index__id) 
        references partition_index (id);

    alter table data 
        add index FK2EEFAA1A68FAD0 (dap_job_configuration__id), 
        add constraint FK2EEFAA1A68FAD0 
        foreign key (dap_job_configuration__id) 
        references dap_job_configuration (id);

    alter table data 
        add index FK2EEFAA8B7CD475 (dap_file__id), 
        add constraint FK2EEFAA8B7CD475 
        foreign key (dap_file__id) 
        references dap_file (id);

    alter table data_base_data_sink 
        add index FKCAAB474FF207CAD2 (id), 
        add constraint FKCAAB474FF207CAD2 
        foreign key (id) 
        references data_sink_configuration (id);

    alter table data_migration 
        add index FKF5E61179677F7CB3 (migration_job__id), 
        add constraint FKF5E61179677F7CB3 
        foreign key (migration_job__id) 
        references dap_job_execution (id);

    alter table data_migration 
        add index FKF5E61179A58C0731 (data__id), 
        add constraint FKF5E61179A58C0731 
        foreign key (data__id) 
        references data (id);

    alter table data_mining_configuration_property 
        add index FK310235F88FEAE148 (configuration_fk), 
        add constraint FK310235F88FEAE148 
        foreign key (configuration_fk) 
        references data_mining_configuration (id);

    alter table data_mining_model 
        add index FK7D7918EFEEB099DB (workbook_data_fk), 
        add constraint FK7D7918EFEEB099DB 
        foreign key (workbook_data_fk) 
        references workbook_data (id);

    alter table data_mining_model_property 
        add index FK58059325DB27247E (configuration_fk), 
        add constraint FK58059325DB27247E 
        foreign key (configuration_fk) 
        references data_mining_model (id);

    alter table data_partition 
        add index FKBD68F0954CF3E322 (partition_index__id), 
        add constraint FKBD68F0954CF3E322 
        foreign key (partition_index__id) 
        references partition_index (id);

    alter table data_sink_configuration 
        add index FKE2FFFAFF33B1E8A8 (id), 
        add constraint FKE2FFFAFF33B1E8A8 
        foreign key (id) 
        references dap_job_configuration (id);

    alter table data_sink_configuration 
        add index FKE2FFFAFFFC4B9162 (sheet_fk), 
        add constraint FKE2FFFAFFFC4B9162 
        foreign key (sheet_fk) 
        references sheet (id);

    alter table data_sink_configuration 
        add index FKE2FFFAFFC9EC2180 (connection_fk), 
        add constraint FKE2FFFAFFC9EC2180 
        foreign key (connection_fk) 
        references data_store (id);

    alter table data_source_configuration 
        add index FK53BD5D4733B1E8A8 (id), 
        add constraint FK53BD5D4733B1E8A8 
        foreign key (id) 
        references dap_job_configuration (id);

    alter table data_source_configuration 
        add index FK53BD5D47C9EC2180 (connection_fk), 
        add constraint FK53BD5D47C9EC2180 
        foreign key (connection_fk) 
        references data_store (id);

    alter table data_source_data 
        add index FKB71C38393AE468A7 (id), 
        add constraint FKB71C38393AE468A7 
        foreign key (id) 
        references data (id);

    alter table data_store 
        add index FK608A640C8B7CD475 (dap_file__id), 
        add constraint FK608A640C8B7CD475 
        foreign key (dap_file__id) 
        references dap_file (id);

    alter table data_store 
        add index FK608A640C58479C91 (db_type_fk), 
        add constraint FK608A640C58479C91 
        foreign key (db_type_fk) 
        references db_driver (id);

    alter table data_store_configuration_property 
        add index FKDEB47C91F99C5468 (configuration_fk), 
        add constraint FKDEB47C91F99C5468 
        foreign key (configuration_fk) 
        references data_store (id);

    alter table db_driver_jar_file_names 
        add index FK7C864B5F512D7AEC (db_driver__id), 
        add constraint FK7C864B5F512D7AEC 
        foreign key (db_driver__id) 
        references db_driver (id);

    alter table deprecated_field_definition_entity 
        add index FKFA0CD9BE7A0E2B69 (workbook_sheet_data_fk), 
        add constraint FKFA0CD9BE7A0E2B69 
        foreign key (workbook_sheet_data_fk) 
        references deprecated_sheet_schema (id);

    alter table deprecated_sheet_column_style 
        add index FKD81DA074718E3455 (column_styles__id), 
        add constraint FKD81DA074718E3455 
        foreign key (column_styles__id) 
        references deprecated_column_style (id);

    alter table deprecated_sheet_column_style 
        add index FKD81DA0748273A497 (sheet__id), 
        add constraint FKD81DA0748273A497 
        foreign key (sheet__id) 
        references sheet (id);

    alter table deprecated_sheet_schema_column_style 
        add index FKE8D756FA30361BD0 (sheet_schema__id), 
        add constraint FKE8D756FA30361BD0 
        foreign key (sheet_schema__id) 
        references deprecated_sheet_schema (id);

    alter table deprecated_sheet_schema_column_style 
        add index FKE8D756FA718E3455 (column_styles__id), 
        add constraint FKE8D756FA718E3455 
        foreign key (column_styles__id) 
        references deprecated_column_style (id);

    alter table deprecated_sheet_schema_sort_keys 
        add index FKCE136DC37896134D (schema_id), 
        add constraint FKCE136DC37896134D 
        foreign key (schema_id) 
        references deprecated_sheet_schema (id);

    alter table deprecated_sheet_schema_sort_keys 
        add index FKCE136DC3F6DEEB45 (sort_keys__id), 
        add constraint FKCE136DC3F6DEEB45 
        foreign key (sort_keys__id) 
        references deprecated_sort_key (id);

    alter table deprecated_sort_sort_keys 
        add index FKAD7452A09DFDF919 (sort__id), 
        add constraint FKAD7452A09DFDF919 
        foreign key (sort__id) 
        references sort (id);

    alter table deprecated_sort_sort_keys 
        add index FKAD7452A0F6DEEB45 (sort_keys__id), 
        add constraint FKAD7452A0F6DEEB45 
        foreign key (sort_keys__id) 
        references deprecated_sort_key (id);

    alter table execution_dependencies 
        add index FK72C222F0BFAEA98E (execution_id), 
        add constraint FK72C222F0BFAEA98E 
        foreign key (execution_id) 
        references dap_job_execution (id);

    alter table execution_dependencies 
        add index FK72C222F05347A736 (depends_on_execution_id), 
        add constraint FK72C222F05347A736 
        foreign key (depends_on_execution_id) 
        references dap_job_execution (id);

    alter table field 
        add index FK5CEA0FA383E2F84 (datasource_id), 
        add constraint FK5CEA0FA383E2F84 
        foreign key (datasource_id) 
        references data_source_configuration (id);

    alter table file_data_sink 
        add index FK60E02705F207CAD2 (id), 
        add constraint FK60E02705F207CAD2 
        foreign key (id) 
        references data_sink_configuration (id);

    alter table file_dependency 
        add index FK590E2DEE474E129C (dependency_file_id), 
        add constraint FK590E2DEE474E129C 
        foreign key (dependency_file_id) 
        references dap_file (id);

    alter table file_dependency 
        add index FK590E2DEE6A35D76C (source_file_id), 
        add constraint FK590E2DEE6A35D76C 
        foreign key (source_file_id) 
        references dap_file (id);

    alter table filter 
        add index FKB408CB789D01E173 (source_sheet__id), 
        add constraint FKB408CB789D01E173 
        foreign key (source_sheet__id) 
        references sheet (id);

    alter table filter_argument 
        add index FKBABD2BA4E28A19C6 (filter_fk), 
        add constraint FKBABD2BA4E28A19C6 
        foreign key (filter_fk) 
        references filter (id);

    alter table folder 
        add index FKB45D1C6ECA900A (permission_fk), 
        add constraint FKB45D1C6ECA900A 
        foreign key (permission_fk) 
        references folder_permission (id);

    alter table folder 
        add index FKB45D1C6E7FC284C7 (parent_folder_fk), 
        add constraint FKB45D1C6E7FC284C7 
        foreign key (parent_folder_fk) 
        references folder (id);

    alter table folder_group_permission 
        add index FK81E55F40CA9060 (permission_id), 
        add constraint FK81E55F40CA9060 
        foreign key (permission_id) 
        references folder_permission (id);

    alter table formula 
        add index FKD79F5166FC4B9162 (sheet_fk), 
        add constraint FKD79F5166FC4B9162 
        foreign key (sheet_fk) 
        references sheet (id);

    alter table group_permission 
        add index FK362E6F8F67340916 (permission__id), 
        add constraint FK362E6F8F67340916 
        foreign key (permission__id) 
        references permission (id);

    alter table infographic_model 
        add index FK620E69248B7CD475 (dap_file__id), 
        add constraint FK620E69248B7CD475 
        foreign key (dap_file__id) 
        references dap_file (id);

    alter table job_configuration_property 
        add index FK5C232DC044CB2C3B (configuration_fk), 
        add constraint FK5C232DC044CB2C3B 
        foreign key (configuration_fk) 
        references dap_job_configuration (id);

    alter table mapping 
        add index FK31EC18CEB35F6114 (datasink_id), 
        add constraint FK31EC18CEB35F6114 
        foreign key (datasink_id) 
        references data_sink_configuration (id);

    alter table role_capability 
        add index FKAD65348180C36F6D (role_id), 
        add constraint FKAD65348180C36F6D 
        foreign key (role_id) 
        references custom_role (id);

    alter table sheet 
        add index FK6855D5FC23E9086 (sort_fk), 
        add constraint FK6855D5FC23E9086 
        foreign key (sort_fk) 
        references sort (id);

    alter table sheet 
        add index FK6855D5FE28A19C6 (filter_fk), 
        add constraint FK6855D5FE28A19C6 
        foreign key (filter_fk) 
        references filter (id);

    alter table sheet 
        add index FK6855D5F4D6C7D6E (sheet_view_fk), 
        add constraint FK6855D5F4D6C7D6E 
        foreign key (sheet_view_fk) 
        references sheet_viewstate (id);

    alter table sheet 
        add index FK6855D5F8F24D722 (data_mining_sheet_configuration_fk), 
        add constraint FK6855D5F8F24D722 
        foreign key (data_mining_sheet_configuration_fk) 
        references data_mining_configuration (id);

    alter table sheet 
        add index FK6855D5FC68E5CE4 (workbook_fk), 
        add constraint FK6855D5FC68E5CE4 
        foreign key (workbook_fk) 
        references workbook_configuration (id);

    alter table sheet 
        add index FK6855D5FFC680123 (external_sheet__id), 
        add constraint FK6855D5FFC680123 
        foreign key (external_sheet__id) 
        references sheet (id);

    alter table sheet 
        add index FK6855D5F43FAFD99 (data_source_id), 
        add constraint FK6855D5F43FAFD99 
        foreign key (data_source_id) 
        references data_source_configuration (id);

    alter table sheet_field 
        add index FK3BA69E1A1795EEBC (field_entities__id), 
        add constraint FK3BA69E1A1795EEBC 
        foreign key (field_entities__id) 
        references field (id);

    alter table sheet_field 
        add index FK3BA69E1A8273A497 (sheet__id), 
        add constraint FK3BA69E1A8273A497 
        foreign key (sheet__id) 
        references sheet (id);

    alter table sheet_snapshot 
        add index FKEAD444A4A58C0731 (data__id), 
        add constraint FKEAD444A4A58C0731 
        foreign key (data__id) 
        references data (id);

    alter table sheet_snapshot_sheet_snapshot 
        add index FK164E119FAC942183 (sheet_snapshot__id), 
        add constraint FK164E119FAC942183 
        foreign key (sheet_snapshot__id) 
        references sheet_snapshot (id);

    alter table sheet_snapshot_sheet_snapshot 
        add index FK164E119F919FE9CE (referenced_inputs__id), 
        add constraint FK164E119F919FE9CE 
        foreign key (referenced_inputs__id) 
        references sheet_snapshot (id);

    alter table sink_data 
        add index FKAD06EDD63AE468A7 (id), 
        add constraint FKAD06EDD63AE468A7 
        foreign key (id) 
        references data (id);

    alter table sort 
        add index FK35F59E9D01E173 (source_sheet__id), 
        add constraint FK35F59E9D01E173 
        foreign key (source_sheet__id) 
        references sheet (id);

    alter table stored_file 
        add index FKAEDA58988B7CD475 (dap_file__id), 
        add constraint FKAEDA58988B7CD475 
        foreign key (dap_file__id) 
        references dap_file (id);

    alter table system_job_configuration 
        add index FK2F23E1E433B1E8A8 (id), 
        add constraint FK2F23E1E433B1E8A8 
        foreign key (id) 
        references dap_job_configuration (id);

    alter table system_job_configuration 
        add index FK2F23E1E43A5B7ADC (full_data_permission_fk), 
        add constraint FK2F23E1E43A5B7ADC 
        foreign key (full_data_permission_fk) 
        references permission (id);

    alter table system_job_data 
        add index FK27599EFC3AE468A7 (id), 
        add constraint FK27599EFC3AE468A7 
        foreign key (id) 
        references data (id);

    alter table temporary_data 
        add index FK8DF074D88B7CD475 (dap_file__id), 
        add constraint FK8DF074D88B7CD475 
        foreign key (dap_file__id) 
        references dap_file (id);

    alter table test_entity 
        add index FKD96EB4308B7CD475 (dap_file__id), 
        add constraint FKD96EB4308B7CD475 
        foreign key (dap_file__id) 
        references dap_file (id);

    alter table test_properties 
        add index FK7EF36F00AF993818 (entity_fk), 
        add constraint FK7EF36F00AF993818 
        foreign key (entity_fk) 
        references test_entity (id);

    alter table usergroup_user 
        add index FK298CF96AFCC7D7C (user_id), 
        add constraint FK298CF96AFCC7D7C 
        foreign key (user_id) 
        references user (id);

    alter table usergroup_user 
        add index FK298CF9677B4E9AD (group_id), 
        add constraint FK298CF9677B4E9AD 
        foreign key (group_id) 
        references user_group (id);

    alter table workbook_configuration 
        add index FKF5BA3AF133B1E8A8 (id), 
        add constraint FKF5BA3AF133B1E8A8 
        foreign key (id) 
        references dap_job_configuration (id);

    alter table workbook_configuration 
        add index FKF5BA3AF1EFE49ACA (workbook_view_fk), 
        add constraint FKF5BA3AF1EFE49ACA 
        foreign key (workbook_view_fk) 
        references workbook_viewstate (id);

    alter table workbook_configuration 
        add index FKF5BA3AF13A5B7ADC (full_data_permission_fk), 
        add constraint FKF5BA3AF13A5B7ADC 
        foreign key (full_data_permission_fk) 
        references permission (id);

    alter table workbook_data 
        add index FK1621734F3AE468A7 (id), 
        add constraint FK1621734F3AE468A7 
        foreign key (id) 
        references data (id);

    alter table workbook_sheet_data 
        add index FKDFFB426F4CF3E322 (partition_index__id), 
        add constraint FKDFFB426F4CF3E322 
        foreign key (partition_index__id) 
        references partition_index (id);

    alter table workbook_sheet_data 
        add index FKDFFB426FEEB099DB (workbook_data_fk), 
        add constraint FKDFFB426FEEB099DB 
        foreign key (workbook_data_fk) 
        references workbook_data (id);

    alter table workbook_sheet_edit_data 
        add index FKEE01111A82DAE998 (workbook_sheet_data_id), 
        add constraint FKEE01111A82DAE998 
        foreign key (workbook_sheet_data_id) 
        references workbook_sheet_data (id);

    alter table workbook_sheet_external_data 
        add index FKA831E67982DAE998 (workbook_sheet_data_id), 
        add constraint FKA831E67982DAE998 
        foreign key (workbook_sheet_data_id) 
        references workbook_sheet_data (id);

    alter table workbook_sheet_external_data 
        add index FKA831E679C0D3661E (referenced_workbook_sheet_data_id), 
        add constraint FKA831E679C0D3661E 
        foreign key (referenced_workbook_sheet_data_id) 
        references workbook_sheet_data (id);

    alter table workbook_sheet_import_data 
        add index FK6AE2A99F82DAE998 (workbook_sheet_data_id), 
        add constraint FK6AE2A99F82DAE998 
        foreign key (workbook_sheet_data_id) 
        references workbook_sheet_data (id);

    alter table workbook_sheet_import_data_data_source_data 
        add index FK806582D9BCA4AB31 (data_source_datas_id), 
        add constraint FK806582D9BCA4AB31 
        foreign key (data_source_datas_id) 
        references data_source_data (id);

    alter table workbook_sheet_import_data_data_source_data 
        add index FK806582D98D47D9ED (workbook_sheet_import_data_workbook_sheet_data_id), 
        add constraint FK806582D98D47D9ED 
        foreign key (workbook_sheet_import_data_workbook_sheet_data_id) 
        references workbook_sheet_import_data (workbook_sheet_data_id);
