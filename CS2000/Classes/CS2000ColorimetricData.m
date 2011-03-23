%author Jan Winter TU Berlin
%email j.winter@tu-berlin.de

classdef CS2000ColorimetricData < handle
    properties
        Le
        Lv
        Lv_mesopic
        Lv_scotopic
        X
        Y
        Z
        x
        y
        u_
        v_
        T
        delta_uv
        lambda_d
        Pe
        X10
        Y10
        Z10
        x10
        y10
        u_10
        v_10
        T10
        delta_uv10
        lambda_d10
        Pe10
        spectralData    %needed for Lv_mesopic / Lv_scotopic
    end % properties
    methods
        %constructor
        function obj = CS2000ColorimetricData(colorArray)
            if nargin > 0 % Support calling with 0 arguments
                obj.Le = colorArray{1};
                obj.Lv = colorArray{2};
                obj.X = colorArray{3};
                obj.Y = colorArray{4};
                obj.Z = colorArray{5};
                obj.x = colorArray{6};
                obj.y = colorArray{7};
                obj.u_ = colorArray{8};
                obj.v_ = colorArray{9};
                obj.T = colorArray{10};
                obj.delta_uv = colorArray{11};
                obj.lambda_d = colorArray{12};
                obj.Pe = colorArray{13};
                obj.X10 = colorArray{14};
                obj.Y10 = colorArray{15};
                obj.Z10 = colorArray{16};
                obj.x10 = colorArray{17};
                obj.y10 = colorArray{18};
                obj.u_10 = colorArray{19};
                obj.v_10 = colorArray{20};
                obj.T10 = colorArray{21};
                obj.delta_uv10 = colorArray{22};
                obj.lambda_d10 = colorArray{23};
                obj.Pe10 = colorArray{24};
            end
        end % constructor
        function value = get.Lv_mesopic(obj)
            if (isempty(obj.Lv_mesopic))
                [obj.Lv_mesopic, ~] = ...
                    mesopicLuminance_recommended(obj.Lv,...
                    obj.Lv_scotopic);
            end
            value = obj.Lv_mesopic;
        end%lazy loading of scotopic data
        function value = get.Lv_scotopic(obj)
            if (isempty(obj.Lv_scotopic))
                obj.Lv_scotopic = ...
                    calcScotopicLuminanceFromSpectrum(obj);
            end
            value = obj.Lv_scotopic;
        end%lazy loading of scotopic data
         %% get spectralData
        function value = get.spectralData(obj)
            if (iscell(obj.spectralData))
                value = cell2mat(obj.spectralData);
            else
                value = obj.spectralData;
            end
        end%set reflectedSpectrum
         %% set spectralData
        function set.spectralData(obj, value)
            if (iscell(value))
                obj.spectralData = cell2mat(value);
            else
                obj.spectralData = value;
            end
        end%set reflectedSpectrum
    end
    methods ( Access = private )
        %%calc scotopic luminance
        function Lv_scotopic = calcScotopicLuminanceFromSpectrum(obj)
            load 'V_strich_CIE.mat'  %load V_strich and lambda_CIE
            lambda_i = calcCS2000Lambda(obj);
            V_strich_i=interp1(lambda_CIE, V_strich, lambda_i);
            Lv_scotopic = 1758 * sum(V_strich_i .* obj.spectralData);
        end
        %%lambda for CS2000
        function lambda = calcCS2000Lambda(obj)
            lambda = linspace(380,780,401);
        end
        
    end % methods
end