with open('d:/workfordasan/frontend/src/views/student/RagChat.vue', 'r', encoding='utf-8') as f:
    content = f.read()

old = """.message-text :deep(table) {
  width: 100%;
  border-collapse: collapse;
  font-size: 13px;
  line-height: 1.6;
}

.message-text :deep(th) {
  background: #f8f9fa;
  font-weight: 600;
  text-align: left;
  padding: 10px 14px;
  border-bottom: 2px solid #e0e0e0;
  color: #1f2328;
  white-space: nowrap;
}

.message.user .message-text :deep(th) {
  background: rgba(255, 255, 255, 0.1);
  border-bottom-color: rgba(255, 255, 255, 0.2);
  color: rgba(255, 255, 255, 0.95);
}

.message-text :deep(td) {
  padding: 9px 14px;
  border-bottom: 1px solid #eee;
  color: #303133;
}

.message.user .message-text :deep(td) {
  border-bottom-color: rgba(255, 255, 255, 0.1);
  color: rgba(255, 255, 255, 0.9);
}

.message-text :deep(tr:last-child td) {
  border-bottom: none;
}

.message-text :deep(tr:hover td) {
  background: #f5f7fa;
}

.message.user .message-text :deep(tr:hover td) {
  background: rgba(255, 255, 255, 0.08);
}"""

new = """.message-text :deep(table) {
  width: 100%;
  border-collapse: collapse;
  font-size: 13px;
  line-height: 1.5;
  border: 1px solid #d0d7de;
}

.message-text :deep(th) {
  background: #eef1f6;
  font-weight: 600;
  text-align: left;
  padding: 10px 14px;
  border: 1px solid #d0d7de;
  color: #1f2328;
  white-space: nowrap;
  font-size: 13px;
}

.message.user .message-text :deep(th) {
  background: rgba(255, 255, 255, 0.15);
  border-color: rgba(255, 255, 255, 0.25);
  color: rgba(255, 255, 255, 0.95);
}

.message-text :deep(td) {
  padding: 9px 14px;
  border: 1px solid #d0d7de;
  color: #303133;
}

.message.user .message-text :deep(td) {
  border-color: rgba(255, 255, 255, 0.15);
  color: rgba(255, 255, 255, 0.9);
}

.message-text :deep(tr:nth-child(even) td) {
  background: #f8f9fb;
}

.message.user .message-text :deep(tr:nth-child(even) td) {
  background: rgba(255, 255, 255, 0.05);
}

.message-text :deep(tr:hover td) {
  background: #f0f4ff;
}

.message.user .message-text :deep(tr:hover td) {
  background: rgba(255, 255, 255, 0.1);
}"""

if old in content:
    content = content.replace(old, new)
    with open('d:/workfordasan/frontend/src/views/student/RagChat.vue', 'w', encoding='utf-8') as f:
        f.write(content)
    print('SUCCESS: Table styles updated')
else:
    print('FAIL: Old styles not found')
    idx = content.find('.message-text :deep(table)')
    if idx >= 0:
        print(f'Found at position {idx}')
        print(repr(content[idx:idx+500]))
