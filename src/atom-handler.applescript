on open location atomURL
	-- URL should take the form of "atm://open?url=file://<path>[&line=<line>[&column=<column>]], e.g. atm://open?url=file://%2Fpath%2Fto%2Ffile&line=10&column=4
	-- Note that file path should be URL encoded.
	-- Slashes (/) should be encoded as %2F.
	-- Spaces should be encoded as %20, NOT as a plus sign (+) because a plus sign is a legal character on filenames!
	set idx to the offset of "url=file://" in atomURL
	set file_path to text from (idx + 11) to -1 of atomURL -- just get the file path and line
	-- 's/^[^&]*/'\"'\"'&'\"'\"'/' -- Surround the file name in strong (single) quotes, e.g. %2Fpath%2Fto%2Ffile&line=3 => '%2Fpath%2Fto%2Ffile'&line=3
	-- s/\\\\%2F/\\\\//g           -- Unencode escaped slashes (/), e.g. '%2Fpath%2Fto%2Ffile' => '/path/to/file'
	-- sed -E 's/%20|\\+/\\ /g'    -- Unencode escaped spaces, e.g. 'user/Google%20Drive/my+project/file' => 'user/Google Drive/my project/file'
	-- sed s/%2B/+/g                -- Unencode escaped plus-signs, e.g. 'project/one%2Btwo/file' => 'project/one+two/file'
	-- s/\\&line=/:/ | sed s/\\&column=/:/  -- Change the format of the line and column parameters, e.g. '/path/to/file'&line=3&column=4 => '/path/to/file':3:4
	set file_path to do shell script "echo '" & file_path & "' | sed 's/^[^&]*/'\"'\"'&'\"'\"'/' | sed s/\\\\%2F/\\\\//g | sed -E 's/%20|\\+/\\ /g' | sed s/%2B/+/g | sed s/\\&line=/:/ | sed s/\\&column=/:/"
	do shell script "/usr/local/bin/atom " & file_path
end open location
