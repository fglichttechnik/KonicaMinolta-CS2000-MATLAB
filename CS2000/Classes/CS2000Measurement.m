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
            x = xlabel('\lambda in nm');
			set(x,'FontSize',14);
            y = ylabel('$$\mbox{L}_{e}(\lambda) \hspace{5pt} \mbox{in} \hspace{5pt}  \frac{\mbox{W}}{\mbox{m}^{2} \hspace{3pt} \mbox{sr} \hspace{3pt} \mbox{nm}}$$');
            set(y,'Interpreter','LaTeX','FontSize',14);
            t = title('Spectral Radiance\fontsize{18}');
            set(t,'FontSize',14);
            
            mini = min(obj.spectralData);
            maxi = max(obj.spectralData);
            meani = mean(obj.spectralData);
            posY3 = meani - (maxi - mini) / 10;
            posY2 = meani;
            posY1 = meani + (maxi - mini) / 10;
            tx = text(600,posY1,sprintf('$$L = %1000.3f cd/m^2$$',obj.colorimetricData.Lv));
            set(tx,'Interpreter','LaTeX','FontSize',12);
            tx = text(600,posY2,sprintf('$$L_{mes} = %1000.3f cd/m^2$$',obj.colorimetricData.Lv_mesopic));
            set(tx,'Interpreter','LaTeX','FontSize',12);
            tx = text(600,posY3,sprintf('$$CCT = %d K$$',obj.colorimetricData.T));
            %tx = text(600,obj.reflectedSpectrum(220),sprintf('$$\mbox{L} = %d \frac{\mbox{cd}}{\mbox{m}^2}$$',obj.reflectedColorimetricData.Lv));
            set(tx,'Interpreter','LaTeX','FontSize',12);
            
            axis('tight');
        end % plot
         %% set spectralData
        function set.spectralData(obj, value)
            if (iscell(value))
                obj.spectralData = cell2mat(value);
            else
                obj.spectralData = value;
            end
        end%set reflectedSpectrum
        %% get spectralData
        function value = get.spectralData(obj)
            if (iscell(obj.spectralData))
                value = cell2mat(obj.spectralData);
            else
                value = obj.spectralData;
            end
        end%set reflectedSpectrum
        %% custom colorimetricData getter
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