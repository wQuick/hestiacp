<VirtualHost %ip%:%web_port%>

    ServerName %domain_idn%
    %alias_string%
    ServerAdmin %email%
    DocumentRoot %docroot%
    ScriptAlias /cgi-bin/ %home%/%user%/web/%domain%/cgi-bin/
    Alias /vstats/ %home%/%user%/web/%domain%/stats/
    Alias /error/ %home%/%user%/web/%domain%/document_errors/
    SuexecUserGroup %user% %group%
    CustomLog /var/log/%web_system%/domains/%domain%.bytes bytes
    CustomLog /var/log/%web_system%/domains/%domain%.log combined
    ErrorLog /var/log/%web_system%/domains/%domain%.error.log

    IncludeOptional %home%/%user%/conf/web/%domain%/forcessl.apache2.conf*

    <IfModule mod_php5.c>
        Define PHP_ENABLED
    </IfModule>
    <IfModule mod_php7.c>
        Define PHP_ENABLED
    </IfModule>
    <Directory %docroot%>
        AllowOverride All
        Options +Includes -Indexes +ExecCGI
        <IfDefine PHP_ENABLED>
            php_admin_value open_basedir %docroot%:%home%/%user%/tmp
            php_admin_value upload_tmp_dir %home%/%user%/tmp
            php_admin_value session.save_path %home%/%user%/tmp
            php_admin_value sys_temp_dir %home%/%user%/tmp
            Action phpcgi-script /cgi-bin/php
            <Files *.php>
                SetHandler phpcgi-script
            </Files>
        </IfDefine>
    </Directory>
    <Directory %home%/%user%/web/%domain%/stats>
        AllowOverride All
    </Directory>
    IncludeOptional %home%/%user%/conf/web/%domain%/%web_system%.conf_*

</VirtualHost>

