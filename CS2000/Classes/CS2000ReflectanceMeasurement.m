classdef CS2000ReflectanceMeasurement < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        reflectedSpectrum
        lampSpectrum
        reflectance
        reflectanceNormalized
        name
        lampTypeName
        reflectedColorimetricData
    end
    
    methods
        %constructor
        function obj = CS2000ReflectanceMeasurement(reflectedSpectrum, lampSpectrum, name, lampTypeName, reflectedColorimetricData)
            if nargin > 0 % Support calling with 0 arguments
                obj.reflectedSpectrum = reflectedSpectrum;
                obj.lampSpectrum = lampSpectrum;
                obj.name = name;
                obj.lampTypeName = lampTypeName;
                obj.reflectedColorimetricData = reflectedColorimetricData;
            end
        end % constructor
        %% set lampSpectrum
        function  set.lampSpectrum(obj, value)
            if (iscell(value))
                obj.lampSpectrum = cell2mat(value);
            else 
                obj.lampSpectrum = value;
            end
        end%set lampspectrum
        %% set reflectedSpectrum
        function set.reflectedSpectrum(obj, value)
            if (iscell(value))
                obj.reflectedSpectrum = cell2mat(value);
            else
                obj.reflectedSpectrum = value;
            end
        end%set reflectedSpectrum
        %% lazy loading of reflectance
        function value = get.reflectance(obj)
            if (isempty(obj.reflectance))
                obj.reflectance = obj.reflectedSpectrum ./ obj.lampSpectrum;
            end
            value = obj.reflectance;
        end%lazy loading of scotopic data
         %%lazy loading of normalized reflectance
        function value = get.reflectanceNormalized(obj)
            if (isempty(obj.reflectanceNormalized))
                arrayWithoutInf = obj.reflectance;
                arrayWithoutInf = arrayWithoutInf(isfinite(arrayWithoutInf));
                obj.reflectanceNormalized = obj.reflectance ./ max(arrayWithoutInf);
            end
            value = obj.reflectanceNormalized;
        end%lazy loading of scotopic data
        %%plot spectrum
        function plotSpectrum(obj,varargin)
            lambda = linspace(380,780,length(obj.reflectedSpectrum));
            if nargin == 1            
                semilogy(lambda, obj.reflectedSpectrum);
            elseif nargin == 2
                semilogy(lambda, obj.reflectedSpectrum, varargin{:});
            end
            x = xlabel('\lambda in nm');
            set(x,'FontSize',14);
            y = ylabel('$$\mbox{L}_{e}(\lambda) \hspace{5pt} \mbox{in} \hspace{5pt}  \frac{\mbox{W}}{\mbox{m}^{2} \hspace{3pt} \mbox{sr} \hspace{3pt} \mbox{nm}}$$');
            set(y,'Interpreter','LaTeX','FontSize',12);
            titleString = strcat({'Spectral Radiance '},obj.name,'\fontsize{14}');
            t = title(titleString);
            set(t,'FontSize',14);
            
            mini = min(obj.reflectedSpectrum);
            maxi = max(obj.reflectedSpectrum);
            meani = mean(obj.reflectedSpectrum);
            posY3 = meani - (maxi - mini) / 10;
            posY2 = meani;
            posY1 = meani + (maxi - mini) / 10;
            tx = text(600,posY1,sprintf('$$L = %1000.3f cd/m^2$$',obj.reflectedColorimetricData.Lv));
            set(tx,'Interpreter','LaTeX','FontSize',12);
            tx = text(600,posY2,sprintf('$$L_{mes} = %1000.3f cd/m^2$$',obj.reflectedColorimetricData.Lv_mesopic));
            set(tx,'Interpreter','LaTeX','FontSize',12);
            tx = text(600,posY3,sprintf('$$CCT = %d K$$',obj.reflectedColorimetricData.T));
            %tx = text(600,obj.reflectedSpectrum(220),sprintf('$$\mbox{L} = %d \frac{\mbox{cd}}{\mbox{m}^2}$$',obj.reflectedColorimetricData.Lv));
            set(tx,'Interpreter','LaTeX','FontSize',12);
            axis('tight');
        end % plot
        %%plot reflectance
        function plotReflectance(obj,varargin)
            lambda = linspace(380,780,length(obj.reflectance));
            if nargin == 1            
                semilogy(lambda, obj.reflectance);
            elseif nargin == 2
                semilogy(lambda, obj.reflectance, varargin{:});
            end
            xlabel('\lambda in nm\fontsize{18}');
            y = ylabel('$$\rho(\lambda) = \frac{\mbox{L}_{e, object}\hspace{8pt}(\lambda)}{\mbox{L}_{e, source}\hspace{8pt}(\lambda)}$$');
            set(y,'Interpreter','LaTeX','FontSize',12);
            titleString = strcat({'Spectral Reflectance '},obj.name,'\fontsize{14}');
            title(titleString);
            axis('tight');

        end % plot
        %%plot reflectance normalized
        function plotReflectanceNormalized(obj,varargin)
            lambda = linspace(380,780,length(obj.reflectanceNormalized));
            if nargin == 1            
                semilogy(lambda, obj.reflectanceNormalized);
            elseif nargin == 2
                semilogy(lambda, obj.reflectanceNormalized, varargin{:});
            end
            xlabel('\lambda in nm\fontsize{14}');
            y = ylabel('$$\rho(\lambda) = \frac{\mbox{L}_{e, object}\hspace{8pt}(\lambda)}{\mbox{L}_{e, source}\hspace{8pt}(\lambda)}$$');
            set(y,'Interpreter','LaTeX','FontSize',12);
            titleString = strcat({'Spectral Reflectance Normalized '},obj.name,'\fontsize{14}');
            title(titleString);
            axis('tight');
        end % plot
    end
    
end

