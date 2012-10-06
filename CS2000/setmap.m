% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.


val = get(hpop,'Value');

if val == 1

    colormap(hsv)

elseif val == 2

    colormap(hot)

elseif val == 3

    colormap(cool)

elseif val == 4

    colormap(gray)

end