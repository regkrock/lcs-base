Class {
	#name : #GtCompilationNotificationSummary,
	#superclass : #GtNotificationSummary,
	#instVars : [
		'executedLabel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtCompilationNotificationSummary >> initialize [
	| tmp2 |
	super initialize.
	self
		constraintsDo: [ :arg1 | 
			arg1 vertical exact: 21.
			arg1 horizontal fitContent ];
		layout: BlLinearLayout horizontal;
		border: (BlBorder paint: Color orange width: 2);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		padding: (BlInsets left: 5 right: 5);
		background: Color white.
	tmp2 := BrLabel new.
	tmp2
		aptitude: BrGlamorousLabelAptitude;
		beSmallSize;
		hFitContent;
		vExact: 15;
		margin: (BlInsets all: 3);
		layout: BlLinearLayout horizontal alignCenter;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self addChild: (executedLabel := tmp2 text: 'Compiling 0%')
]

{ #category : #accessing }
GtCompilationNotificationSummary >> subscribeToNotifications [
	notifications
		do: [ :arg1 | 
			arg1 job announcer
				when: JobChange
				send: #requestUpdate
				to: self ]
]

{ #category : #accessing }
GtCompilationNotificationSummary >> unsubscribeFromNotifications [
	notifications do: [ :arg1 | arg1 job announcer unsubscribe: self ]
]

{ #category : #accessing }
GtCompilationNotificationSummary >> updateSummaryContent [
	| tmp2 tmp3 |
	tmp2 := tmp3 := 0.
	self notifications
		do: [ :arg1 | 
			tmp2 := tmp2 + arg1 job currentValue.
			tmp3 := tmp3 + arg1 job max ].
	executedLabel
		text: 'Compiling ' , (tmp2 * 100 / tmp3 printShowingDecimalPlaces: 0) , '%'
]
