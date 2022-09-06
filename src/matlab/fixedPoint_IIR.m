%% fixed point IIR model



function y = fixedPoint_IIR(x ,a1 ,b0 ,b1 ,WL_IN ,FL_IN ,WL_OUT ,FL_OUT ,WL_COEF ,FL_COEF ,WL_INTER ,FL_INTER)
    persistent w
    if isempty(w)
        w = fi(0, 1, WL_INTER, FL_INTER);
    end
    x_f = fi(x, 1, WL_IN, FL_IN, 'RoundingMethod', 'Floor');
    a1_f = fi(a1, 1, WL_COEF, FL_COEF, 'RoundingMethod', 'Floor');
    b1_f = fi(b1, 1, WL_COEF, FL_COEF, 'RoundingMethod', 'Floor');
    b0_f = fi(b0, 1, WL_COEF, FL_COEF, 'RoundingMethod', 'Floor');
    wa = fi(-a1_f * w, 1, WL_INTER, FL_INTER, 'RoundingMethod', 'Floor');
    wb = fi(b1_f * w, 1, WL_INTER, FL_INTER, 'RoundingMethod', 'Floor');
    v = fi(x_f + wa, 1, WL_INTER, FL_INTER, 'RoundingMethod', 'Floor');
    vb = fi(b0_f * v, 1, WL_INTER, FL_INTER, 'RoundingMethod', 'Floor');
    y = fi(vb + wb, 1, WL_OUT, FL_OUT, 'RoundingMethod', 'Floor');
    w = fi(v, 1, WL_INTER, FL_INTER, 'RoundingMethod', 'Floor');
end