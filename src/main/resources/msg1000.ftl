${staticMethod.set-table-status('0')}
${staticMethod.set-table-header('')}
${staticMethod.set-caption('')}
${staticMethod.render-header()}
${staticMethod.render-body()}
${staticMethod.render-footer()}
${staticMethod.parse-col(<p class='title'>,0)}
${staticMethod.display_cur_text(unit_name_transform_FUN(MD@B))}
${staticMethod.parse-col(收到,0)}
${staticMethod.display_cur_text(trans_word_FUN('Order',MD@C))}
${staticMethod.parse-col(命令情况报告</p>,0)}
${staticMethod.process-br()}
${staticMethod.display_cur_text(unit_name_transform_FUN(MD@B))}
${staticMethod.parse-col(收到,0)}
${staticMethod.display_cur_text(trans_word_FUN('Order',MD@C))}
${staticMethod.parse-col(命令，,0)}
${staticMethod.parse-col(命令编号为,0)}
${staticMethod.display_cur_text(MD@D)}
${staticMethod.parse-col(。,0)}
${get-table-status()}
${normalize-space(${in_string})}
${replace-func(${in_string},' '' ','&nbsp;')}
${substring-before(${header-string},'|'})}
${staticMethod.set-table-header($header-string)}
${staticMethod.set-table-status(5)}
${get-table-status()}
${staticMethod.set-table-status(0)}
${get-table-status()}
