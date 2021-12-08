#include "PROTHEUS.CH"
#include "RESTFUL.CH"

#xtranslate @{Header <(cName)>} => ::GetHeader( <(cName)> )
#xtranslate @{Param <n>} => ::aURLParms\[ <n> \]
#xtranslate @{EndRoute} => EndCase
#xtranslate @{Route} => Do Case
#xtranslate @{When <path>} => Case NGIsRoute( ::aURLParms, <path> )
#xtranslate @{Default} => Otherwise


WSRESTFUL WSLIGUE DESCRIPTION "Serviço REST para manutenção e consulta de tabelas do Banco de Dados"

    WSDATA CHAVE      AS STRING
    WSDATA OCORRENPTB AS STRING
    WSDATA OCORRENSPA AS STRING
    WSDATA OCORRENENG AS STRING
    
    WSMETHOD GET    DESCRIPTION "Retorno de ocorrencia(s)"              WSSYNTAX "/ocurrences || /ocurrences/{recno}" 
    WSMETHOD POST   DESCRIPTION "Adiciona uma nova ocorrencia"          WSSYNTAX "/ocurrences/{}"
    WSMETHOD PUT    DESCRIPTION "Atualiza os dados de ocorrencia(s)"    WSSYNTAX "/ocurrences/{recno}"
    WSMETHOD DELETE DESCRIPTION "Delela o registro de uma ocorrencia"   WSSYNTAX "/ocurrences/{recno}"

END WSRESTFUL


WSMETHOD GET WSSERVICE WSLIGUE
Local aArea       := GetArea()
Local cTABELA     := SuperGetMV("MV_ZTABPAD",.T.,"ZZ")      // Tabela Padrão
Local cFILIAL     := SuperGetMV("MV_ZFILPAD",.T.,"LG01")    // Filial Padrão
Local cOCORRE

    ::SetContentType("application/json")

    @{Route}

        @{When '/ocurrences'}
            
            DbSelectArea("SX5")
            SX5->( DbSetOrder(1) )
            SX5->( DbGoTop() )
            SX5->( DbSeek( cFILIAL + cTABELA ))
            
            cOCORRE := '['
            While SX5->(!Eof()) .And. SX5->( X5_FILIAL + X5_TABELA ) == ( cFILIAL + cTABELA )

                cOCORRE +=  '{"Chave":' + AllTrim(SX5->X5_CHAVE) + ;
                            ',"Ocorrencia":' + AllTrim(SX5->X5_DESCRI) + ;
                            ',"RECNO":' + cVAlToChar(SX5->(Recno())) + '}'
                            
                SX5->(DbSkip())
            
            EndDo
            cOCORRE += ']'

        @{When '/ocurrences/{recno}'}
            
            DbSelectArea("SX5")
            dbGoto(Val(Self:aURLParms[2]))
            
            if Deleted()
                SetRestFault(410,"Nao existe mais, o registro ja foi deletado!")
                Return .F. 
            else
                cOCORRE :=  '[{"Chave":' + AllTrim(SX5->X5_CHAVE) + ;
                            ',"Ocorrencia":' + AllTrim(SX5->X5_DESCRI) + ;
                            ',"RECNO":' + cVAlToChar(SX5->(Recno()))  + '}]'
            EndIf

        @{Default}
            SetRestFault(400,"Solicitacao incorreta!")
            Return .F. 

    @{EndRoute}

    ::SetResponse(cOCORRE)
    RestArea(aArea)

Return(.T.)


WSMETHOD POST WSSERVICE WSLIGUE
Local aArea       := GetArea()
Local cCHAVE      := AllTrim(Self:CHAVE)
Local cOCORRENPTB := AllTrim(Self:OCORRENPTB)
Local cOCORRENSPA := AllTrim(Self:OCORRENSPA)
Local cOCORRENENG := AllTrim(Self:OCORRENENG)
Local cTABELA     := SuperGetMV("MV_ZTABPAD",.T.,"ZZ")
Local cFILIAL     := SuperGetMV("MV_ZFILPAD",.T.,"LG01")
Local cOCORRE

    if !Empty(cOCORRENPTB) .And. !Empty(cOCORRENSPA) .And. !Empty(cOCORRENENG)  

        BEGIN TRANSACTION

            lMsErroAuto := .F.
            DbSelectArea("SX5")
            RecLock("SX5", .T.)	
                SX5->X5_FILIAL  := cFILIAL	
                SX5->X5_TABELA  := cTABELA
                SX5->X5_CHAVE   := cCHAVE
                SX5->X5_DESCRI  := cOCORRENPTB
                SX5->X5_DESCSPA := cOCORRENSPA
                SX5->X5_DESCENG := cOCORRENENG
            MsUnLock()

            If lMsErroAuto
                DisarmTransaction()
                SetRestFault(500,"Erro interno do servidor!")
            
            else
                
                cOCORRE :=  '[{"Chave":' + AllTrim(SX5->X5_CHAVE) + ;
                            ',"Ocorrencia":' + AllTrim(SX5->X5_DESCRI) + ;
                            ',"RECNO":' + cVAlToChar(SX5->(Recno())) + '}]'
            
            EndIf

        END TRANSACTION

    else

        SetRestFault(400,"Solicitacao incorreta, campos obrigatorios nao preenchidos!")
        Return .F.
        
    EndIf

    ::SetResponse(cOCORRE)
    RestArea(aArea)

Return(.T.)


WSMETHOD PUT WSSERVICE WSLIGUE
Local aArea       := GetArea()
Local cCHAVE      := AllTrim(Self:CHAVE)
Local cOCORRENPTB := AllTrim(Self:OCORRENPTB)
Local cOCORRENSPA := AllTrim(Self:OCORRENSPA)
Local cOCORRENENG := AllTrim(Self:OCORRENENG)
Local cTABELA     := SuperGetMV("MV_ZTABPAD",.T.,"ZZ")
Local cFILIAL     := SuperGetMV("MV_ZFILPAD",.T.,"LG01")
Local cOCORRE

    if !Empty(cOCORRENPTB) .And. !Empty(cOCORRENSPA) .And. !Empty(cOCORRENENG)  
        
        @{Route}
            @{When '/ocurrences/{recno}'}

                BEGIN TRANSACTION

                    lMsErroAuto := .F.
                    DbSelectArea("SX5")
                    dbGoto(Val(Self:aURLParms[2]))

                    if Deleted()
                        SetRestFault(410,"Nao existe mais, o registro ja foi deletado!")
                        Return .F. 
                    else

                        RecLock("SX5", .F.)
                            SX5->X5_FILIAL  := cFILIAL	
                            SX5->X5_TABELA  := cTABELA
                            SX5->X5_CHAVE   := cCHAVE
                            SX5->X5_DESCRI  := cOCORRENPTB
                            SX5->X5_DESCSPA := cOCORRENSPA
                            SX5->X5_DESCENG := cOCORRENENG
                        MsUnLock()

                        If lMsErroAuto
                            DisarmTransaction()
                            SetRestFault(500,"Erro interno do servidor!")
                        
                        else
                            
                            cOCORRE :=  '[{"Chave":' + AllTrim(SX5->X5_CHAVE) + ;
                                        ',"Ocorrencia":' + AllTrim(SX5->X5_DESCRI) +;
                                        ',"RECNO":' + cVAlToChar(SX5->(Recno()))  + '}]'
                        
                        EndIf

                    Endif

                END TRANSACTION
            
            @{Default}
                SetRestFault(400,"Solicitacao incorreta!")
                Return .F. 

        @{EndRoute}

    else

        SetRestFault(400,"Solicitacao incorreta, campos obrigatorios nao preenchidos!")
        Return .F.
        
    EndIf

    ::SetResponse(cOCORRE)
    RestArea(aArea)

Return(.T.)


WSMETHOD DELETE WSSERVICE WSLIGUE
Local aArea       := GetArea()
Local cOCORRE

     @{Route}
            @{When '/ocurrences/{recno}'}

                BEGIN TRANSACTION
                
                    lMsErroAuto := .F.
                    DbSelectArea("SX5")
                    dbGoto(Val(Self:aURLParms[2]))

                    if Deleted()
                        SetRestFault(410,"Nao existe mais, o registro ja foi deletado!")
                        Return .F. 
                    else

                        RecLock("SX5", .F.)
                            DBDelete()
                        MsUnLock()

                        If lMsErroAuto
                            DisarmTransaction()
                            SetRestFault(500,"Erro interno do servidor!")
                        
                        else
                            
                            cOCORRE :=  '[{"Chave":' + AllTrim(SX5->X5_CHAVE) + ;
                                        ',"Ocorrencia":' + AllTrim(SX5->X5_DESCRI) + ;
                                        ',"RECNO":' + cVAlToChar(SX5->(Recno()))  + ;
                                        ',"Situacao":' + 'REGISTRO DELETADO COM SUCESSO!' + '}]'
                        
                        EndIf

                    EndIf

                END TRANSACTION

            @{Default}
                SetRestFault(400,"Solicitacao incorreta!")
                Return .F. 

        @{EndRoute}

    ::SetResponse(cOCORRE)
    RestArea(aArea)

Return(.T.)
