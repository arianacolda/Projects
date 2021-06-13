%% a
H = tf(15,[1 5 0]); % process tf
H0 = minreal(H/(1+H));
figure, step(H0)

%% c
Ts1 = 0.1;
Hd_zoh1 = c2d(H,Ts1,'zoh')
Hd_tustin1 = c2d(H,Ts1,'tustin')

%% d
Ts2 = 1;
Ts3 = 2;
Hd_zoh2 = c2d(H,Ts2,'zoh')
Hd_tustin2 = c2d(H,Ts2,'tustin')
Hd_zoh3 = c2d(H,Ts3,'zoh')
Hd_tustin3 = c2d(H,Ts3,'tustin')

%% e
H0_zoh1 = feedback(Hd_zoh1,1)
H0_zoh2 = feedback(Hd_zoh2,1)
H0_zoh3 = feedback(Hd_zoh3,1)
H0_tustin1 = feedback(Hd_tustin1,1)
H0_tustin2 = feedback(Hd_tustin2,1)
H0_tustin3 = feedback(Hd_tustin3,1)

%% f
figure, 
step(H0), hold on, 
step(H0_zoh1), hold on,
step(H0_zoh2), hold on,
step(H0_zoh3), hold on
step(H0_tustin1), 
step(H0_tustin2), 
step(H0_tustin3),

legend('continuous','0.1 zoh', '1 zoh', '2 zoh', '0.1 tustin','1 tustin', '2 tustin');
