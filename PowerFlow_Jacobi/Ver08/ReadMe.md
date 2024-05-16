PV Bus가 여러 개일 때 Bus Switching이 정상적으로 동작하도록 코드를 수정.
raw data의 정보로부터 Bus Type을 자동으로 구분하도록 코드를 추가.
14 Bus System의 6,8번 PV Bus의 Q_G 수렴값이 limit을 초과하여 PQ Bus로 전환됨.
PSCAD 시뮬레이션 결과는 6,8번 V값이 초기값으로 유지되는 것으로 보아 PQ Bus로 전환되면 안 되는 것 같음.
