Attribute VB_Name = "Module1"
Sub WizzAir()
Attribute WizzAir.VB_ProcData.VB_Invoke_Func = " \n14"
    
    Dim objHTTP As New MSXML2.XMLHTTP60

    URL = "https://be.wizzair.com/3.5.0/Api/search/search"
    Dim huf As Double
    Dim moneyCode As String
    
    j = 2
    While Cells(j, 1) <> Empty

        AirportTo = Right(Cells(j, 1).value, 3)
        
        isFirst = True
        huf = 0
        
        i = 2
        While Cells(1, i) <> Empty
        
            NowDate = Format(Cells(1, i).value, "yyyy-mm-dd")
            
            objHTTP.Open "POST", URL, False
            objHTTP.setRequestHeader "Content-Type", "application/json"
            objHTTP.send ("{""flightList"": [{""departureStation"": ""BUD"", ""arrivalStation"": """ & AirportTo & """, ""departureDate"": """ & NowDate & """}], ""adultCount"":1, ""childCount"":0, ""infantCount"":0,  ""wdc"":false}")
            
            from = InStr(objHTTP.ResponseText, "basePrice") + 21
            fromTo = InStr(objHTTP.ResponseText, ".")
            
            If from <> 21 Then
                Cells(j, i).value = Mid(objHTTP.ResponseText, from, fromTo - from)
            Else
                Cells(j, i).value = "-"
            End If
            
            objHTTP.Open "POST", URL, False
            objHTTP.setRequestHeader "Content-Type", "application/json"
            objHTTP.send ("{""flightList"": [{""departureStation"": """ & AirportTo & """, ""arrivalStation"": ""BUD"", ""departureDate"": """ & NowDate & """}], ""adultCount"":1, ""childCount"":0, ""infantCount"":0,  ""wdc"":false}")
            from = InStr(objHTTP.ResponseText, "basePrice") + 21
            fromTo = InStr(objHTTP.ResponseText, ".")
            
            
            If from <> 21 Then
                Cells(j + 1, i).value = Mid(objHTTP.ResponseText, from, fromTo - from)
                
                If isFirst = True Then
                    moneyCode = Mid(objHTTP.ResponseText, InStr(objHTTP.ResponseText, "currencyCode") + 15, 3)
                    huf = MoneyToHUF(moneyCode)
                    'If huf = 0 Then
                    '    Cells(j + 1, 1) = moneyCode
                    'End If
                    Cells(j + 1, 1) = moneyCode
                    isFirst = False
                End If
                
                If huf <> 0 Then
                    Cells(j + 1, i).value = Cells(j + 1, i).value * huf
                End If
            Else
                Cells(j + 1, i).value = "-"
            End If

            i = i + 1
        Wend
        j = j + 2
    Wend
    
    j = 122
    While Cells(j, 1) <> Empty
    
        AirportTo = Right(Cells(j, 1).value, 3)
        
        isFirst = True
        huf = 0
        
        i = 2
        While Cells(1, i) <> Empty
            NowDate = Format(Cells(1, i).value, "yyyy-mm-dd")
            
            objHTTP.Open "POST", URL, False
            objHTTP.setRequestHeader "Content-Type", "application/json"
            objHTTP.send ("{""flightList"": [{""departureStation"": ""DEB"", ""arrivalStation"": """ & AirportTo & """, ""departureDate"": """ & NowDate & """}], ""adultCount"":1, ""childCount"":0, ""infantCount"":0,  ""wdc"":false}")
            from = InStr(objHTTP.ResponseText, "basePrice") + 21
            fromTo = InStr(objHTTP.ResponseText, ".")
            
            If from <> 21 Then
                Cells(j, i).value = Mid(objHTTP.ResponseText, from, fromTo - from)
            Else
                Cells(j, i).value = "-"
            End If
            
            objHTTP.Open "POST", URL, False
            objHTTP.setRequestHeader "Content-Type", "application/json"
            objHTTP.send ("{""flightList"": [{""departureStation"": """ & AirportTo & """, ""arrivalStation"": ""DEB"", ""departureDate"": """ & NowDate & """}], ""adultCount"":1, ""childCount"":0, ""infantCount"":0,  ""wdc"":false}")
            from = InStr(objHTTP.ResponseText, "basePrice") + 21
            fromTo = InStr(objHTTP.ResponseText, ".")
            
            If from <> 21 Then
                Cells(j + 1, i).value = Mid(objHTTP.ResponseText, from, fromTo - from)
                
                If isFirst = True Then
                    moneyCode = Mid(objHTTP.ResponseText, InStr(objHTTP.ResponseText, "currencyCode") + 15, 3)
                    huf = MoneyToHUF(moneyCode)
                    'If huf = 0 Then
                    '    Cells(j + 1, 1) = moneyCode
                    'End If
                    Cells(j + 1, 1) = moneyCode
                    isFirst = False
                End If
                
                If huf <> 0 Then
                    Cells(j + 1, i).value = Cells(j + 1, i).value * huf
                End If
            Else
                Cells(j + 1, i).value = "-"
            End If

            i = i + 1
        Wend
        j = j + 2
    Wend
    
    Call Coloring
    
End Sub


Sub Coloring()
    
    j = 2
    While Cells(j, 1) <> Empty
        
        For t = 0 To 1
            
            i = 2
            While Cells(1, i) <> Empty
                
                Price = Cells(j + t, i).value
                    
                If Price <= 5000 Then
                    Cells(j + t, i).Interior.Color = RGB(94, 245, 87)
                ElseIf Price <= 10000 Then
                    Cells(j + t, i).Interior.Color = RGB(129, 202, 74)
                ElseIf Price <= 15000 Then
                    Cells(j + t, i).Interior.Color = RGB(172, 202, 74)
                ElseIf Price <= 20000 Then
                    Cells(j + t, i).Interior.Color = RGB(202, 185, 74)
                ElseIf Price <= 30000 Then
                    Cells(j + t, i).Interior.Color = RGB(219, 97, 97)
                ElseIf Price <> "-" Then
                    Cells(j + t, i).Interior.Color = RGB(215, 18, 18)
                End If
                
                i = i + 1
            Wend
        Next t
        
        j = j + 2
    Wend
    
    j = 122
    While Cells(j, 1) <> Empty
        
        For t = 0 To 1
            i = 2
            While Cells(1, i) <> Empty
                
                Price = Cells(j + t, i).value
                    
                If Price <= 5000 Then
                    Cells(j + t, i).Interior.Color = RGB(94, 245, 87)
                ElseIf Price <= 10000 Then
                    Cells(j + t, i).Interior.Color = RGB(129, 202, 74)
                ElseIf Price <= 15000 Then
                    Cells(j + t, i).Interior.Color = RGB(172, 202, 74)
                ElseIf Price <= 20000 Then
                    Cells(j + t, i).Interior.Color = RGB(202, 185, 74)
                ElseIf Price <= 30000 Then
                    Cells(j + t, i).Interior.Color = RGB(219, 97, 97)
                ElseIf Price <> "-" Then
                    Cells(j + t, i).Interior.Color = RGB(215, 18, 18)
                End If
                
                i = i + 1
            Wend
        Next t
                
        j = j + 2
    Wend
    
    
End Sub

Function MoneyToHUF(moneyCode As String) As Double

    Dim objHTTP As New MSXML2.XMLHTTP60

    'objHTTP.Open "GET", "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml", False
    
    objHTTP.Open "GET", "http://api.napiarfolyam.hu/?bank=otp", False
    objHTTP.send ("")
    
    from = InStr(objHTTP.ResponseText, moneyCode)
    If from <> 0 Then
        from = InStr(Mid(objHTTP.ResponseText, from, 100), "<eladas>") + from + 7
        fromTo = InStr(Mid(objHTTP.ResponseText, from, 100), "<")
        
        MoneyToHUF = CDbl(Replace(Mid(objHTTP.ResponseText, from, fromTo - 1), ".", ","))
    Else
        MoneyToHUF = 0
    End If
    
End Function
