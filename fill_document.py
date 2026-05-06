# -*- coding: utf-8 -*-
"""
使用Win32 COM直接编辑Word文档
"""
import win32com.client
import os
from win32com.client import constants

def fill_document():
    # 打开原始文档
    doc_path = r'D:\workfordasan\docs\教学一体化平台升级改造中期自查报告.doc'
    word = win32com.client.Dispatch('Word.Application')
    word.Visible = False
    doc = word.Documents.Open(doc_path)

    # 遍历文档中的所有内容
    for para in doc.Paragraphs:
        text = para.Range.Text.strip()
        print(f"Found paragraph: {text[:50]}...")

    doc.Close(False)
    word.Quit()

if __name__ == '__main__':
    fill_document()