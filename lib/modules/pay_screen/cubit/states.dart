abstract class PaymentStates{}
class PaymentInitialState extends PaymentStates{}


class PaymentAuthLoadingState extends PaymentStates{}
class PaymentAuthSuccessState extends PaymentStates{}
class PaymentAuthErrorState extends PaymentStates{}

class GetOrderLoadingState extends PaymentStates{}
class GetOrderSuccessState extends PaymentStates{}
class GetOrderErrorState extends PaymentStates{}



class PaymentRequestLoadingState extends PaymentStates{}
class PaymentRequestSuccessState extends PaymentStates{}
class PaymentRequestErrorState extends PaymentStates{}




class UpdateTargetSuccessState extends PaymentStates{}
class UpdateTargetErrorsState extends PaymentStates{}
