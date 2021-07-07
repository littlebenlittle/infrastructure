gpg2 --import $master_key
gpg2 --edit-key 0x427F11FD0FAA4B080123F01CDDFA1A3E36879494
# set master key to ultimate trust

signing_key_fpr=`gpg2 --fingerprint $release_signing_key`
echo $signing_key_fpr
gpg2 --check-signatures $signing_key_fpr
gpg2 -v --verify $release_signing_key $qubes_iso
