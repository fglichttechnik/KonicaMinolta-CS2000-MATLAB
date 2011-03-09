%author Jan Winter TU Berlin
%email j.winter@tu-berlin.de

classdef CS2000Measurement < handle
    properties
        timeStamp
        spectralData
        colorimetricData
        aperture
        comments
        lightSource
    end % properties
    methods
        %constructor
        function obj = CS2000Measurement(timeStamp,spectralData,colorimetricData)
            if nargin > 0 % Support calling with 0 arguments
                obj.timeStamp = timeStamp;
                obj.spectralData = spectralData;
                obj.colorimetricData = CS2000ColorimetricData(colorimetricData);
            end
        end % constructor
        %redefinition of plot
        function plot(obj,varargin)
            lambda = linspace(380,780,length(obj.spectralData));
            if nargin == 1            
                semilogy(lambda, obj.spectralData);
            elseif nargin == 2
                semilogy(lambda, obj.spectralData, varargin{:});
            end
            xlabel('\lambda in nm\fontsize{18}');
            ylabel('L_{e}(\lambda) in W / m^{2} sr nm\fontsize{18}');
            title('Spectral Radiance\fontsize{18}');
            axis('tight');
        end % plot
        %%custom colorimetricData getter
        %we need this in order to make sure, that colorimetric data has
        %access to spectral data for mesopic calculation
        function value = get.colorimetricData(obj)
            if(isempty(obj.colorimetricData))
                obj.colorimetricData = CS2000ColorimetricData();
            end
            if (isempty(obj.colorimetricData.spectralData))
                obj.colorimetricData.spectralData = obj.spectralData;                  
            end
            value = obj.colorimetricData;
        end%lazy loading of scotopic data
        %%lambda for CS2000
        function lambda = calcCS2000Lambda
            lambda = linspace(380,780,401);
        end
    end % methods
end