#!/bin/bash

prepare_commit_msg_path=".git/hooks/prepare-commit-msg"

# Content of the prepare-commit-msg file
prepare_commit_msg_content="#!/bin/bash

commit_msg_title=\$(head -n 1 \"\$1\")
commit_msg_body=\$(tail -n +2 \"\$1\")

# Regular expression pattern to match specific commit types at the beginning of the commit message
commit_type_regex=\"^(\\[(Feat|Add|Delete)\\])\"

if [[ \$commit_msg_title =~ \$commit_type_regex ]]; then
	commit_type=\"\${BASH_REMATCH[1]}\"
	echo \"\$commit_type \$commit_msg_title\" > \"\$1\"
else
	echo \"Invalid commit type. Available commit types: [Feat], [Add], [Delete]\"
	exit 1
fi

if [[ -n \$commit_msg_body ]]; then
	echo \"\$commit_msg_body\" >> \"\$1\"
fi
"

# Create the prepare-commit-msg file
echo "$prepare_commit_msg_content" > "$prepare_commit_msg_path"
chmod +x "$prepare_commit_msg_path"

echo "prepare-commit-msg file has been added to .git/hooks folder."
