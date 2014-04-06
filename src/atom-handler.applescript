on open location atomURL
	-- URL should take the form of "atm://open?file://<path>[?line=<line>]
	set idx to the offset of "url=file://" in atomURL
	set file_path to text from (idx + 11) to -1 of atomURL
	set file_path to do shell script "echo '" & file_path & "' | sed s/\\\\%2F/\\\\//g | sed s/\\&line=/:/ | sed s/\\&column=/:/"
	do shell script "/usr/local/bin/atom " & file_path
end open location
