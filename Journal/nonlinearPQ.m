function [ F] = nonlinearPQ(v, sL, Y, Y_NS, vS )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
F=-conj(sL./v)-Y*v-Y_NS*vS;

end

