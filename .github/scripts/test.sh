cwd=$(pwd)
files=$(cat files.csv)
for file in ${files//,/ }
do
    printf "\nfile: $file\n"
    directory="$(dirname "${file}")"
    if [[ $directory =  *"profiles"* ]]; then
        printf "this is a profile\n"
        printf "directory: ${directory}\n"

        cd directory

        printf "starting profile comparison \n\n"

        for profile in *;
        do
            new_profile="$(basename "${file}")"
            printf "base: ${new_profile}\n"
            printf "profile: ${profile}\n"
            if [[ "$new_profile" != "$profile" ]]; then
                if cmp -s "$profile" "$new_profile"; then
                    printf "files are the same\n"
                else
                    printf "files are different\n"
                fi
            fi

            printf "\n"
        done
    else
        printf "not a profile\n"
    fi

    cd $cwd

    printf "\n"
done
