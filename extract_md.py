import re
import os

with open('d:/workfordasan/111.sql', 'r', encoding='utf-8') as f:
    content = f.read()

output_dir = 'd:/workfordasan/test_doc'
os.makedirs(output_dir, exist_ok=True)

start = content.find('insert  into `knowledge_items`')
end = content.rfind(';') + 1
insert_sql = content[start:end]

rows = re.split(r"\),\s*\(", insert_sql)

count = 0
for i, row in enumerate(rows):
    row = row.strip()
    if not row.startswith('('):
        row = '(' + row

    parts = re.split(r",\s*'", row)

    if len(parts) >= 4:
        try:
            title = parts[1].replace("\\'", "'").replace("\\\\", "\\").strip()
            content_text = parts[2].replace("\\'", "'").replace("\\\\", "\\").replace("\\n", "\n").strip()

            # Clean title for filename - remove trailing quote
            title = title.rstrip("'")
            filename = title
            for char in ['/', '\\', ':', '*', '?', '"', '<', '>', '|']:
                filename = filename.replace(char, '_')
            filename = filename.strip()

            if filename and content_text and title:
                # If content already starts with the title as H1, don't duplicate
                if content_text.startswith(f"# {title}"):
                    final_content = content_text
                else:
                    final_content = f"# {title}\n\n{content_text}"

                filepath = os.path.join(output_dir, f"{filename}.md")

                counter = 1
                original_filename = filename
                while os.path.exists(filepath):
                    filename = f"{original_filename}_{counter}"
                    filepath = os.path.join(output_dir, f"{filename}.md")
                    counter += 1

                with open(filepath, 'w', encoding='utf-8') as out:
                    out.write(final_content)

                count += 1
                print(f"[{count}] {filename}.md")

        except Exception as e:
            print(f"Error on row {i}: {e}")

print(f"\nTotal: {count} files created in {output_dir}")