VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sheet1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub InsertEquation(str)
    ActiveSheet.Shapes.AddLabel(msoTextOrientationHorizontal, 0, 0, 0, 0).Select
    Selection.Font.Size = 15
    Application.CommandBars.ExecuteMso "InsertBuildingBlocksEquationsGallery"
    Selection.Text = str
    Selection.ShapeRange.TextFrame2.WordWrap = msoFalse
    Application.CommandBars.ExecuteMso "EquationProfessional"
End Sub
Sub Sample()
    InsertEquation "F(t)=\sum_(x=0)^(n-1) \of \begin f(x) e^(-\ii  2\pi tx/N) \end"
End Sub
Sub OutputMatrix()
'<summary>
' OutputMatrix : ()
'</summary>
'<remarks>
' �Z�����當��������擾���čs�񉻂��ďo�͂���
' �󔒌���0�Ƃ��ď�������
'</remarks>
    '#region �ϐ�
    Dim matrixCommand As String          ' �s��R�}���h�p�̕�����(String�^)
    Dim i, j As Integer                  ' �J�E���g�p�̕ϐ�(int�^)
    Dim outputPermission As Integer      ' �s��o�͋��̊m�F
    '#endregion (�ϐ�)
    matrixCommand = "(\matrix("          ' �s��R�}���h�쐬�J�n
    If (TypeName(Selection) <> "Range") Then    ' �Z����I�����Ă��Ȃ��ꍇ�ُ͈�I��
        MsgBox "�Z����I�����Ă�������"
        End                              ' �I��
    End If
    For i = Selection.Row To (Selection.Row + Selection.Rows.Count - 1)
        For j = Selection.Column To (Selection.Column + Selection.Columns.Count - 1)
            matrixCommand = matrixCommand & nullToZero(Cells(i, j).Value)   ' �Z�����̃e�L�X�g�����擾
            If (j <> Selection.Column + Selection.Columns.Count - 1) Then   ' �I��͈͂̏I�[�̏ꍇ�̏���
                matrixCommand = matrixCommand & "&"
            End If
        Next j
        If (i <> Selection.Row + Selection.Rows.Count - 1) Then
            matrixCommand = matrixCommand + "@"                             ' �I��͈͂̏I�[�̏ꍇ�̏���
        End If
    Next i
    matrixCommand = matrixCommand + "))" ' �s��擾�R�}���h�쐬�I��
    outputPermission = MsgBox("�s����o�͂��܂�����낵���ł����H", vbYesNo, "�s��o��")
    If (outputPermission = vbYes) Then
        InsertEquation matrixCommand
    End If
End Sub
Function nullToZero(ByVal target As String)
'<summary>
' nullToZero : (���� : String)
'</summary>
'<remarks>
' ������ɉ����������0��Ԃ��֐�
' �֐������ă��\�b�h(�T�u���[�`��)�̍s�������炷
'</remarks>
    If target = "" Then
        nullToZero = "0"
    Else
        nullToZero = target
    End If
End Function
