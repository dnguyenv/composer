(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else   
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� =Y �]Ys⺶����y�����U]u�	�`c�֭�g&cc~�1��3t҉w�j�� 	Yַ֒��$�t���+7^���K��i�xEiyx��_(�"$��4M���8FR�ȯi�cl����j�S{;�^.�V���#�'��v��^N�z/�O�˟�)��xK��)����!AV�/��������GI
��_.����^q��;.�?�V������>[ǩ��@�\��b����5|�o'^���r�E�8
�"�;y?��{4%����|Q{�N�i�_+�V���3�i�v1w��<��)��Q��Q�b��q�e����Q��HsmǣHE��o��{^G�?��xQ��$�X���QԐ2:���WGpbCVk"/�A���&0�Z[�Ny��ty���,#�.��&���[�j��Z��P6m-hS���Zv�)�� n����W�،���@O+16)=�;�|<7�}��QQ��:�=��񔥇��VB�F��� �f�OX�z_^Ⱥ,R�B�#[��������Щ��*���tG�����o{�t����u���FW�����qu|{��у{���QǞ���*�_
�^�Y��Bm�j~Y����\�@(k�R�Y��2C�gͥ�m-��0\M�nO�0�BE�r��,�Դ�����A4��F �<��5L���x�Fdb�P�S�S�&mdq���!9�G��9����'��6̅;g�ヸ��B��b�Mn1�zn���A�!⊠���z�ŌG�!i�^=ܧ� v0?�`����Сs͡��Չ�XD���Cq'������Y�M��I[,��oā�q�t1�S�b>��Cso୥bpc�S��L� O
��
p�����yxsh���H"S�n$L�^�[\c�ƨ��s��/;hS@�N��䒡ʅ�ʻ�R�L�ŭ�L�f�E�F�S q|~O�E�5�(�dz�>h���@���kp+O<��p `��Q�:��xY���"cR��M����� ��z`m:�������}�\)L�B�<@B��^�x�:tr �	>��-�F\Ę�2�`���>;��ߵs9䖓�%���D�b�ՇL�@�"=�cш�̢O�Q��>,>0���zf��_���4|���Q���R�I����x��ѧ���E��K�[�/�
�w�;�ׁzd�7�;u��%�-��=q��%��|�!G�8*�3F��P��1��	���#;� � WS�.�
�{e�ާ)����u��e��i(��C�ل��<��.G�މE�r	��b�֐�ek�Dj�b��.:7��,��ty�H�\̭�m�.�}
@s�e�Rw���=s�mu�4@.�'���	s�0��ax�@����4���Y�@��"�9�W ������k��k��Aȁ3_�A7��}���|Ƿ4�צ����4���A#�9�u �-�5�.��̶��	�4���qG�"j>ob��bM�CAn�{�I���sn
��L�k�t���mfՇJ&�����)~I���;��#�O�t�Q
>E��9�}��Gh���T���W���k���wL���O�Q��%�e�Oe���*�������O��$�^@�lqu�"���a��a���]sY��(?pQ2@1g=ҫ��)�!�7�������U�_� ��o���~�Ѥ���#��u�u<K�s�G ��e�?�����-ض�`FL�9i��e�l)�z�"��Ɨs�3ܠ��Ȃ�`�͍9�Z�+���u�`5J�`�Y��4��>�_��_�S����ϒ�g���t���@��W��U���߇��W��T�_
>I���?%����J������ߛ9	�G(L���.@^����`�����%�~4kpl�L̇0�н�4��с
��*@�tb�I�7���txs�;��H��H�\u:w��f�z3�7l�k���AS�(^��b�.u�A��U;Ǝ�Y�{�u�9Ҷxd\�ǈ�#}/8���sr��8m�<f	��i��� =����4�+qz��	'�h>Cm��LBDy�Z|g����haڳ'�&Te p�� j��a���ЬG����l�]wZ����Ҟ)-K�z��͎���#JH;#)ɜ�H^�n�@B�<�+���z�Z��|�����2����|���"����RP����_���=�n���>�r�G
���\"�7h�E\���������+��������!���Z� U�_���=�&�p�Q��Ѐ�	�`h׷4�0�u=7pg؂�a	�gQ�%Iʮ��~?�!�����"+��\��2aW�W���X�plNl����{���6[�A�z�^��C	��yܩ�JJ�E�Il/��j����hc7�1c���������<D i�l0h�C���<�甒S�ݬ���0��8���ӏ����Gi�Z�/���������:��\(��ח)���_X��/����ۗ/+���O�]ɿ|��_�z��qC�����wX��p���O�Z�)_2�Y���ň��ǶI��)�B]�B<�`Y�����w]7��%� p|�eX��JC�|�� T���������Aj�h�(��P�A����0�.���]#M���/���4���v]wW����s)���aDn5f����Q�5#���n��������j=qMP��	ff�^��|�9�_����D*����JO�?
�+��|���}i�P�2Q��߰�P�|�M D�������1������9+9�Vᯱ�% ��7�g�?�g�}��$������7����*-û���֍��{�� �w�ݰ����s��Mk?lڹe�@��S���)�b^<�]h�i���&1]���&�����k��4�Gx,�3��gr�CMf=Q'���7G����Q[x+.�K����Dӭ3�YO>�#ܖ�Q�2��8��n�u_;ms.���k ��ݚ�r.k)ZV�y:E��ڔ�9��t��nw�cC��B�w{�C ����䶷�<����à�bM p"�r65�y{WW\����Vd���Fg9�,3�V�֟��A��߃ j�;%6�NГr�&{+~f��ni���p�5��!��x����/m�������_
~���+��������Vn�o�2�����l�'������}�?���?�m�a��o��N2;M�p�g�?�O��qo(�g���@y�@wA޻d�d����5`�5M|��?�+�A@�H���PwSR������ؚ���ms�ѷl���D��!�5S9v-Mhҩl�$��ԺN�t-�\9N�j�x�<���?�l�C�����}�@�,4GN�F��Y�ͻ�����2�g�d5���ן��v�^�=�K�^����w:��M!��#Z�������g�?�g��������/�W��෰��g�������Z�����h�����2P��W�������N���S`.��1����\.�˭����P���,�W�_��������E=_�����\���G�4�a(�R�C�,�2��`���h��.��>J8d��T��>B�.�8�W���V(C�o�?;��4�+���q����Lɖ�þeN�6;}�!Bs�m�me�E��#mѢ&/��1ќ��J;�����(���)�G�  �mow���c�o]�5�Oaz���z8#P�249�P�7�+u�Ŧ=4���|^������Qg��>Z|�=^��(��O�!P����R��Ӭ���jcCP�۩�gߠZ͵��V�Fv��M���.|/,�c`;�Խr�o;����+��F��E2�O���i/#�>WR�]�$��2Ã�fW���څZ�ձ~z�`���G���a����?��b�F���V�&�+����:jG�kWE��q�"�.�ڛw~rڏ��sEsY=�pr^�ʩ�6X|;�M�kWީ��b�����T�o�}���^����Oo�vT�
׾��*
��
�#�i��7��m���VWD]�o�*�sӑ���A��~�;r}�y���ڗ��h4����l�**ɝ���sG�w�:��4̮o��Yz���vy�Q�=Y��=�x�fiA֟� ʒ;���
�N����#�j/���X�I"}~����<<��>ΐW�z�T�^��|{�6��5x����We����y>c�%|�rQi�a��?55���t�x��[��5Ɖ���Y���t=�8ׅ���t{$�{��0�&,t rT��ϔ�Y<��w�Q�����[>��mO��s�p�zC7�\���.��M �|Wođ�ѐ�;0��G�qYU�����l*Ŝz]Y5�o���7�'q���v
��%|�������ɞ����6�u�L������v��v��!�����:���(u�8�8N�|'Ku��8v'�����
H�H��E��@��?*@�_�����E���u�в[��8vO2If2��m)>W�������>~��9�@���}ؽ�K��t6gLlr�rKn%$l"��Y*��������芬�t.���Jgc�(	�m];f�:��P������fSd��c3��E�E�V�i�G�h1�	A�d^����P�!&Ly��+����(� ����]��.A�F �5�� �ڱ2�0�R��Z\�k�7,�l�����P�Ǧ*i���G��a��~G��O�����/��-���[5�����+ĻE�3;��c0���37�UY#4��H�-����g�u�h[��F����[(��KSƪ�&jb�f܂��9ۋ��)�M�76���-���y8���k39p�����4�����z_��NL�4`�u�V����:��]��)�H��^��j�%<��q�G�sJ�Ӛ�,�Z:�[�T�ͤMX����'�A�>r�ܰ�Q0G:��拰�~|A���D疮�k����2�xT�&����*L��ᐹh+��E���PpZr[�a��+9s�1S
�a[����\nB���e��)��7������Yjt�jK\Z������t��ѱ^����ْ�	n�0��~�^��G�=��h��NZ��G�KR�:Sf�\�xk�!�v�1A+��$f�i;��=���ɹ��!,�bg�P��d�W�ת�N�.�l��ַ��}�.��-�bVՀ~:����f�QD��
��p>��A���u��V������?��pk�?��ϫ��/��iPں�si�����r�c�č'���7��y�!��}?�������"����@��w��0����0�OD\��#W��}�+?�ϧ������?.�������g�a�;�c�����@8�u7�8��#/<��k�M���א/\C>wm��W.�@j�����xqWZ"0��9n�``s����GⲐb�m&l�5H��x�s��&Y��'�y�Y�����o��Æ�dO ���V�J�F�}ԛHU�ro�[B��0G{�B�S���cN(u�v	c���"YaX��}Ќ�t�<.�D�Yl�g��m�`ɊI�Hvs��[���"����0*0�Va�h|@Ȇ8̲y6<�.1�*l�'g«d�1����R$�͏�Z���)K:�T��F3_0R�U)�j���zGJHi�ȣᴁJ)c���*��ň��=��i��Y�0dU+Ǒ��/_r���a�nE�|"��GL�e�E��ܦ�a�M=�)�5?��f����Ss#dݫG��F<���1/��Nz��P.��w��~Uh&Uth$1P�Ź0^(Ҹ�vZ�5О��r.J�[�h1�� ��!+͍{\�V3(�A� ��r<��)t	Y�/�N�,!+ً������dCu���U�b�ˍr5���@���O6�$�r��j��P��B=�N���~*Y�Ԓ�q��		.v�6����D�IY�l���,{��n�?�%�ZI�Q�x��Z��c	+�^rB'-�{�x��:�Z�%ʙ��f¥$#{�Z'c
UmT�}�t�Br
[4�
c��L0,��"��(�%e9"� �VY⺏��C<Ӕ�l�ī��A����y_4�fe��e4�������{XXgұF+��jqP����DJ
u�"��VY��e�BY��+Kse�㉁�1�W�8M{�<�R�<���؛�zc�]�/~4�eE�C��ң�/�{�nj\���dK8��Q,���PS��)KTN7��(F�q=TUA��2�l�*pؒ�^�]�,\d���8���Ɛ�*����Q�����SR��Oy����ݖ����h�B�R�_��˱|Z�1l�����^�;NY܎���l�϶�϶s�4~�w��FW��]ȵ�;�d��^غc�
���Wi;�L���ʾ}.�6re>����UeE�v��v��滂l���^�����{چ-��B��9(�*a�<���#AԺ��LN�<�&1��ht���U�@�檺��gĎ�3�#MD��Kࢡ*�-��X��5�"����~�ocW�y�ew�m�U��֛0��}������"�4jVˑ�"�B�{��1W�=l���ļ��.�+��up��48�
����1+V��)��A�� �����@��U �]V$}������D����?���y��6�ۇ�9/�K��/ϝ��,<��d;4�5s�>Q
S�b'�������}�A[)����\t0��<4�E�a�~��}e�邃�#�p�g���1߬9����I�=`� Rb*������̮��i���c�P�B�Xy�H��c����,��� D~)��e��W)�E�ܦ�l�*�fy����R���LkM2&�	�����5���ݘ͒�#{���JD��bz���ן���D�����5
4�J�8�d�b���P�ԒAm��h���|ԇuP���7�F`\l펇#c��B�$�pG��hӋ�n�D }�F�j��ϥ�Qd"z�q��p��1��Xϡ���6�T�uι�l�CS�d>��g�0f{v�"A��2܋\�3��3�{�������c|�O�ayo���D��8��M"���ߪDki��"u!�ś��K
d���G�<Z��MR�Eȅ��,&���
L�"�͚�����0�ryg�����"�v��#tX�c���݌!�O�ZG���zBɪ֧�V�`�����qt4�h��Q0&!E��`��X8m0�0B���E��}��b���q߁��p����'U�w1\Ԇ����E���rU�zcR�)�~%S#Ӣ.U�1��R3�ǃ("lmO-���qCN�)$Z� |��E�ڬb�^?Mz�
-�����c�q��ǩ��b�o#��{j�l!����Br��vn���]���qސ)��{B��[�­��tߜ��4�I�j�h�G�>p�����������.�mA���\�����hTY���M���"r��vso���ˏ�����z?����/~��{��^��s~r��o���k�ws�bZ9Q���8�������8��ے�{��կ�׷�b�/���7�a���O&x�3����d�k�w�_D�=	��_L� xp�N�~hqE/wEc2��QCv���K~���������Cy�?�}�ŗ�����y�7x�A~� ���v�̍��H���C�t���ӡ	84���|�}��u�N@ڡv:�N����l���z�v��oy��7NA�܄W)3���M�m�@޶�:�x��s���31t6��!~�:��5���8n��3p>�:�R��c�q�f<�3p$���d��zin��:O˙3�D[�93δ gZ�3g�1�8nÜ�3��=���13��y��NZ۔���Gϑ�y^�R{����Nr�����m�+�g��  