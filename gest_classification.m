function [value]=gest_classification(data)
F=features(data);
[W Wo]=weights();
Wo;
v=Wo+W*F';
[a value]=max(v(:));

