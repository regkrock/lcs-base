Class {
	#name : 'LuiDomainPresenter',
	#superclass : 'LuiPresenter',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'components' }
LuiDomainPresenter >> addLabelAndWidgetComponentFor: aSlotName [
	self addComponent: (LuiLabelWithInputComponent onSlotNamed: aSlotName model: self model)
]

{ #category : 'components' }
LuiDomainPresenter >> addLabelAndWidgetComponentFor: aSlotName widgetClass: aWidgetClass [
	self addComponent: (LuiLabelWithInputComponent onSlotNamed: aSlotName model: self model widgetClass: aWidgetClass)
]

{ #category : 'components' }
LuiDomainPresenter >> addLabelAndWidgetComponentFor: aSlotName widgetClass: aWidgetClass inputComponentName: aString [
	self addComponent: (LuiLabelWithInputComponent onSlotNamed: aSlotName model: self model widgetClass: aWidgetClass inputComponentName: aString)
]

{ #category : 'rendering' }
LuiDomainPresenter >> renderComponentOn: html [
	html div
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]
