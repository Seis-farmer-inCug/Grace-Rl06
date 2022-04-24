function [cnm, snm, GM, R]=readgracerl06(filename)

fid = fopen(filename);

hasErrors = true;

% read header
while 1
  line = fgetl(fid);
  if ~ischar(line), break, end
  if isempty(line), continue, end
  keyword = textscan(line,'%s',1);

  if(strcmp(keyword{1}, 'max_degree'))
    cells = textscan(line,'%s%d',1);
    maxDegree = cells{2};
  end

  if(strcmp(keyword{1}, 'radius'))
    cells = textscan(line,'%s%f',1);
    R = cells{2};
  end

  if(strcmp(keyword{1}, 'earth_gravity_constant'))
    cells = textscan(line,'%s%f',1);
    GM = cells{2};
  end

  if(strcmp(keyword{1}, 'errors'))
    cells = textscan(line,'%s%s',1);
    if(strcmp(cells{2}, 'no'))
      hasErrors = false;
    end
  end

  if(strcmp(keyword{1}, 'end_of_head'))
    break
  end
end

% init the output matricies.
cnm = zeros(maxDegree+1, maxDegree+1);
snm = zeros(maxDegree+1, maxDegree+1);

% read potential coefficients
while 1
  line = fgetl(fid);
  if ~ischar(line), break, end
  if isempty(line), continue, end
  if(hasErrors)
    cells = textscan(line,'%s%d%d%f%f%f%f');
  else
    cells = textscan(line,'%s%d%d%f%f');
  end
  cnm(cells{2}+1, cells{3}+1) = cells{4};
  snm(cells{2}+1, cells{3}+1) = cells{5};
end

fclose(fid);